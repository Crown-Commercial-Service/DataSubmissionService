class UserDetailsController < ApplicationController
  def show
    @suppliers = API::Supplier.all
    @email_verification = API::EmailVerification.email_verification_pending?
    @user_logs = API::User.user_auth_logs
  end

  def edit; end

  def update
    new_name = params[:name]

    api_response = API::User.update_name(name: new_name)

    if api_response.any?
      redirect_to user_detail_path, notice: 'Your name has been updated successfully.'
    else
      flash.now[:alert] = 'There was a problem updating your name. Please try again.'
      render :edit, status: :unprocessable_entity
    end
  rescue JSONAPI::Consumer::Errors::ConnectionError
    flash.now[:alert] = 'There was a problem connecting to the user service. Please try again later.'
    render :edit, status: :service_unavailable
  end

  def edit_email; end

  def update_email
    new_email = params[:email]
    email_confirmation = params[:email_confirmation]

    error_message = email_update_validation(new_email, email_confirmation)
    if error_message
      flash.now[:alert] = error_message
      return render :edit_email, status: :unprocessable_entity
    end

    api_response = API::User.update_email(email: new_email)

    if api_response.any?
      redirect_to user_detail_path,
                  notice: 'You must verify your new email address. Please check your inbox for a verification email.'
    else
      flash.now[:alert] = 'There was a problem updating your email address. Please try again.'
      render :edit_email, status: :unprocessable_entity
    end
  rescue JSONAPI::Consumer::Errors::ConnectionError
    flash.now[:alert] = 'There was a problem connecting to the user service. Please try again later.'
    render :edit_email, status: :service_unavailable
  end

  def deactivate_confirmation
    return if current_user.can_deactivate?

    redirect_to user_detail_path,
                alert: 'You cannot deactivate your account because you are the only active user for a linked supplier.'
  end

  def deactivate
    unless current_user.can_deactivate?
      return redirect_to user_detail_path,
                         alert: 'You cannot deactivate your account because you are the only active user for a linked supplier.'
    end

    API::User.deactivate

    reset_session

    redirect_to root_path, notice: 'Your account has been deactivated.'
  rescue JSONAPI::Consumer::Errors::UnprocessableEntity
    redirect_to user_detail_path,
                alert: 'You can no longer deactivate your account because you are the only active user for a linked supplier.'
  rescue JSONAPI::Consumer::Errors::ConnectionError
    redirect_to deactivate_confirmation_user_detail_path,
                alert: 'There was a problem connecting to the user service. Please try again later.'
  end

  private

  def email_update_validation(email, confirmation)
    return 'Please enter and confirm your email address.' if email.blank? || confirmation.blank?
    return 'Email addresses do not match. Please try again.' unless email == confirmation
    return 'Please enter a valid email address.' unless email =~ URI::MailTo::EMAIL_REGEXP

    nil
  end
end
