class SessionsController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def create
    session[:auth_id] = auth_hash.uid

    Auditor.new.user_signed_in(user_id: auth_hash.uid)

    redirect_to '/tasks'
  end

  def destroy
    Auditor.new.user_signed_out(user_id: session[:auth_id])

    reset_session
    session[:auth_id] = nil

    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
