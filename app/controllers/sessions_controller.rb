class SessionsController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def create
    session[:auth_id] = auth_id
    
    # if !email_verified?
    #   reset_session
    #   redirect_to verify_email_path
    #   return
    # end

    Auditor.new.user_signed_in(user_id: auth_id)

    redirect_to '/tasks'
  end

  def verify_email
    render :verify_email
  end


  private

  def email_verified?
    if auth_hash.info.respond_to?(:email_verified)
      !!auth_hash.info.email_verified
    elsif auth_hash.extra && auth_hash.extra.raw_info && auth_hash.extra.raw_info.respond_to?(:email_verified)
      !!auth_hash.extra.raw_info.email_verified
    else
      false
    end
  end

  def destroy
    Auditor.new.user_signed_out(user_id: session[:auth_id])

    reset_session
    session[:auth_id] = nil

    redirect_to '/'
  end

  protected

  def auth_id
    Auth.issue(auth_hash.uid)
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
