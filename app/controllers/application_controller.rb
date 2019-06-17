class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :ensure_user_signed_in

  helper_method :current_user_id
  helper_method :ensure_user_signed_in
  helper_method :current_user
  helper_method :correction?

  private

  def current_user_id
    return nil if session[:jwt].blank?

    begin
      payload = JWT.decode(session[:jwt], public_key, true, algorithm: 'RS256')
      payload[0]['sub'] # auth_id
    rescue JWT::ExpiredSignature
      redirect_to '/auth/auth0?prompt=none'
    end
  end

  def current_user
    @current_user ||= API::User.find(auth_id: current_user_id).first
  end

  def ensure_user_signed_in
    return if current_user_id.present?

    redirect_to root_path
  end

  def set_current_request_details
    Current.jwt = session[:jwt]
  end

  def correction?
    params[:correction] == 'true'
  end

  def public_key
    @public_key ||= begin
                      pubkey = ENV['AUTH0_JWT_PUBLIC_KEY']
                      OpenSSL::PKey.read(pubkey)
                    end
  end
end
