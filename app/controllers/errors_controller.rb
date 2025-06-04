class ErrorsController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def not_found
    render status: :not_found
  end

  def internal_server_error
    error = params[:error]
    error_description = params[:error_description]

    if error.blank? && request.env['omniauth.error'].present?
      error = request.env['omniauth.error'].message
      error_description = request.env['omniauth.error'].message
    end

    flash[:alert] = "#{error} : #{error_description}" if error.present?
    render status: :internal_server_error
  end

  def auth_failure
    error = params[:error]
    error_description = params[:error_description]
    
    if error.blank? && request.env['omniauth.error'].present?
      error = request.env['omniauth.error'].message
      error_description = request.env['omniauth.error'].message
    end

    flash[:alert] = "#{error} : #{error_description}" if error.present?
    render 'auth_failure', status: :unauthorized
  end
end
