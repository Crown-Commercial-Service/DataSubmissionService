class ApplicationController < ActionController::Base
  before_action :ensure_user_signed_in

  helper_method :current_user_id
  helper_method :ensure_user_signed_in

  private

  def current_user_id
    session[:auth_id]
  end

  def ensure_user_signed_in
    return if current_user_id.present?

    redirect_to root_path
  end
end
