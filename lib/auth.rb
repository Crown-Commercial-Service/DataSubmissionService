class Auth
  ALGORITHM = 'HS256'.freeze
  
  def self.issue(payload)
    JWT.encode(
        payload,
        auth_secret,
        ALGORITHM)
  end

  def self.auth_secret
    ENV["AUTH_SECRET"]
  end
end