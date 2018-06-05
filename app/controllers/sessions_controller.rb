class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id

    redirect_to '/tasks', notice: 'You are now signed in'
  end

  def destroy
    session[:user_id] = nil

    redirect_to '/', notice: 'You are now signed out'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
