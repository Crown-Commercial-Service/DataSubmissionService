class EmailVerificationsController < ApplicationController
  skip_before_action :ensure_user_signed_in, only: [:show]

  def show
    @verification = API::EmailVerification.verify_email(tokened: params[:token])

    @message = if @verification
                 'You’ve successfully verified your email. You can now continue to your account.'
               else
                 'Verification link is invalid or has expired.'
               end
  rescue StandardError => e
    Rails.logger.warn("Email verification failed: \\#{e.class} - \\#{e.message}")
    @message = 'Verification link is invalid or has expired.'
  end

  def resend_email
    if API::User.update_email(email: params[:email]).any?
      redirect_to user_detail_path, notice: 'A new verification email has been sent to your new email address.'
    end
  rescue JSONAPI::Consumer::Errors::ConnectionError
    redirect_to user_detail_path, alert: 'There was a problem connecting to the email service. Please try again later.'
  end

  def cancel_pending_email_change
    if API::EmailVerification.delete_pending_email_change
      redirect_to user_detail_path, notice: 'Your pending email change has been cancelled.'
    else
      redirect_to user_detail_path, alert: 'There was a problem cancelling your pending email change. Please try again.'
    end
  rescue JSONAPI::Consumer::Errors::ConnectionError
    redirect_to user_detail_path, alert: 'There was a problem connecting to the email service. Please try again later.'
  end
end
