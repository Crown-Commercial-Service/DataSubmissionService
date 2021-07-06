# require 'omniauth/strategies/conclavesso'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider(
    :auth0,
    ENV['AUTH0_CLIENT_ID'],
    ENV['AUTH0_CLIENT_SECRET'],
    ENV['AUTH0_DOMAIN'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile',
      audience: "https://#{ENV['AUTH0_DOMAIN']}/userinfo"
    }
  )

  # if OmniAuth::Strategies::Conclavesso.applies?
  #   # provider :conclavesso
  #   provider(
  #     :auth0,
  #     ENV['CON_CLIENT_ID'],
  #     ENV['CON_CLIENT_SECRET'],
  #     "#{ENV['CON_DOMAIN']}/security/",
  #     callback_path: '/auth/oauth/authorize',
  #     authorize_params: {
  #       scope: 'openid profile',
  #       audience: "https://#{ENV['CON_DOMAIN']}/security/"
  #     }
  #   )
  # else
  #   provider(
  #     :auth0,
  #     ENV['AUTH0_CLIENT_ID'],
  #     ENV['AUTH0_CLIENT_SECRET'],
  #     ENV['AUTH0_DOMAIN'],
  #     callback_path: '/auth/auth0/callback',
  #     authorize_params: {
  #       scope: 'openid profile',
  #       audience: "https://#{ENV['AUTH0_DOMAIN']}/userinfo"
  #     }
  #   )
  # end
end
