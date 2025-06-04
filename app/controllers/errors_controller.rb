class ErrorsController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def not_found
    render status: :not_found
  end

  def internal_server_error
    flash[:alert] = params[:error_description] if params[:error_description].present?
    render status: :internal_server_error
  end

  def auth_failure
    flash[:alert] = params[:error_description] if params[:error_description].present?
  end
end
