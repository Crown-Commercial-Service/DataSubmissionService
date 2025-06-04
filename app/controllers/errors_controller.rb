class ErrorsController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def not_found
    render status: :not_found
  end

  def internal_server_error
    error = request.env['omniauth.error'].error_reason if request.env['omniauth.error'].present?
    flash[:alert] = error if error.present?
    render status: :internal_server_error
  end

  def auth_failure
    error = request.env['omniauth.error'].error_reason if request.env['omniauth.error'].present?
    flash[:alert] = error if error.present?
    render 'auth_failure', status: :unauthorized
  end
end
