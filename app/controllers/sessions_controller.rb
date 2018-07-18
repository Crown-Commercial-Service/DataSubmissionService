class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id

    Auditor.new.user_signed_in(user_id: user.id)

    redirect_to '/tasks', notice: 'You are now signed in'
  end

  def destroy
    Auditor.new.user_signed_out(user_id: session[:user_id])

    session[:user_id] = nil

    redirect_to '/', notice: 'You are now signed out'
  end

  def create_from_api
    if params[:commit] == 'Log in'
      sign_in(params)
    elsif params[:commit] == 'Sign up'
      register(params)
    end
  end

  def register(params)
    auth = Authenticator.new.sign_up(params: params)
    if auth.code == 200
      user = User.from_auth0(auth)
      session[:user_id] = user.id

      Auditor.new.user_signed_in(user_id: user.id)

      redirect_to '/tasks', notice: 'You are now signed in'
    else
      # handle error
      error = JSON.parse(auth.body)
      flash.now[:alert] = error['message'].to_s + error['policy'].to_s
      render :new
    end
  end

  def sign_in(params)
    auth = Authenticator.new.authorize_with_password(params: params)
    if auth.code == 200
      user = User.from_auth0(auth)
      session[:user_id] = user.id

      Auditor.new.user_signed_in(user_id: user.id)

      redirect_to '/tasks', notice: 'You are now signed in'
    else
      # handle error
      error = JSON.parse(auth.body)
      flash.now[:alert] = error['message'].to_s + error['policy'].to_s
      render :new
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
