class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id

    conn.post '/v1/events/user_signed_in' do |req|
      req.params['user_id'] = user.id
    end

    redirect_to '/tasks', notice: 'You are now signed in'
  end

  def destroy
    conn.post '/v1/events/user_signed_out' do |req|
      req.params['user_id'] = session[:user_id]
    end

    session[:user_id] = nil

    redirect_to '/', notice: 'You are now signed out'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def conn
    Faraday.new(url: ENV['API_ROOT'])
  end
end
