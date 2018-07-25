class User < ApplicationRecord
  def self.from_omniauth(auth)
    User.find_or_create_by(uid: auth.uid) do |u|
      u.email = auth.info.name
      u.auth_hash = auth
    end
  end

  def self.from_auth0(auth)
    User.find_or_create_by(uid: auth._id) do |u|
      u.email = auth.email
      u.auth_hash = auth
    end
  end
end
