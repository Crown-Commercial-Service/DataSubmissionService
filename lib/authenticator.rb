class Authenticator
  include HTTParty
  base_uri ENV['AUTH0_DOMAIN']

  def get_user_info(token:)
    response = self.class.get('/userinfo', headers: { Authorization: "Bearer #{token}" })
    puts response.body
    response
  end

  def authorize_with_password(params:)
    # On the Dashboard, visit https://manage.auth0.com/#/tenant and set
    # Default Directory: 'Username-Password-Authentication',
    # Default Audience: 'https://esther-test.eu.auth0.com/api/v2/'
    # And in Application Settings, Enable Password as Grant Types
    body = {
      client_id: ENV['AUTH0_CLIENT_ID'],
      client_secret: ENV['AUTH0_CLIENT_SECRET'],
      username: params[:email],
      password: params[:password],
      grant_type: 'password',
      scope: 'openid'
    }

    response = self.class.post('/oauth/token', body: body)
    response_body = JSON.parse(response.body)

    token = response_body['access_token']
    puts token
    get_user_info(token: token)
  end

  def sign_up(params:)
    body = {
      email: params[:email],
      password: params[:password],
      connection: 'Username-Password-Authentication',
      client_id: ENV['AUTH0_CLIENT_ID']
    }

    response = self.class.post('/dbconnections/signup', body: body)
    puts response.body
    response
  end
end
