class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :ensure_user_signed_in

  helper_method :current_user_id
  helper_method :ensure_user_signed_in
  helper_method :current_user
  helper_method :correction?

  private

  def current_user_id
    session[:auth_id]
  end

  def current_user
    @current_user ||= API::User.find(auth_id: current_user_id).first
  end

  def ensure_user_signed_in
    return if current_user_id.present?
    return if request.path == '/check'

    redirect_to root_path
  end

  def set_current_request_details
    Current.auth_id = session[:auth_id]
  end

  def correction?
    params[:correction] == 'true'
  end
end
