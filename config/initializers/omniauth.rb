OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider(
    :auth0,
    ENV['CONCLAVE_DOMAIN'],
    ENV['CONCLAVE_CLIENT_ID'],
    ENV['CONCLAVE_CLIENT_SECRET'],
    callback_path: '/auth/oauth/authorize',
    authorize_params: {
      scope: 'openid profile email'
    }
  )

  # Legacy Auth0 Login Config, (in case we want to restore).
  #
  # provider(
  #   :auth0,
  #   ENV['AUTH0_CLIENT_ID'],
  #   ENV['AUTH0_CLIENT_SECRET'],
  #   ENV['AUTH0_DOMAIN'],
  #   callback_path: '/auth/auth0/callback',
  #   authorize_params: {
  #     scope: 'openid profile',
  #     audience: "https://#{ENV['AUTH0_DOMAIN']}/userinfo"
  #   }
  # )
end
