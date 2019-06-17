class SessionsController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def create
    session[:jwt] = auth_hash['credentials']['id_token']

    Auditor.new.user_signed_in(user_id: auth_hash.uid)

    redirect_to '/tasks'
  end

  def destroy
    payload = JWT.decode(session[:jwt], nil, false)
    auth_id = payload[0]['sub']

    Auditor.new.user_signed_out(user_id: auth_id)

    session[:jwt] = nil

    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
