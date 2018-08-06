class SessionsController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id

    Auditor.new.user_signed_in(user_id: user.id)

    redirect_to '/tasks'
  end

  def destroy
    Auditor.new.user_signed_out(user_id: session[:user_id])

    session[:user_id] = nil

    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
