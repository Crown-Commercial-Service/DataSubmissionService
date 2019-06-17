module SingleSignOnHelpers
  def mock_sso_with(email:, uid: '123456')
    # NB Auth0 returns email address in `name` field
    payload = {
      name: email,
      iss: 'https://auth0.fake',
      sub: "auth0|#{uid}",
      iat: Time.zone.now.to_i,
      exp: 10.hours.from_now.to_i
    }

    private_key = OpenSSL::PKey.read(File.read(Rails.root.join('spec', 'fixtures', 'jwtRS256.key')))
    token = JWT.encode(payload, private_key, 'RS256')

    OmniAuth.config.mock_auth[:auth0] = OmniAuth::AuthHash.new(
      provider: 'auth0',
      uid: "auth0|#{uid}",
      info: {
        name: email,
      },
      credentials: {
        id_token: token
      }
    )
  end

  def mock_sso_failure(message)
    OmniAuth.config.mock_auth[:auth0] = message
  end
end
