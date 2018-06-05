module SingleSignOnHelpers
  def mock_sso_with(email:, uid: '123456')
    # NB Auth0 returns email address in `name` field
    OmniAuth.config.mock_auth[:auth0] = OmniAuth::AuthHash.new(
      provider: 'auth0',
      uid: "auth0|#{uid}",
      info: {
        name: email,
      }
    )
  end
end
