class User < ApplicationRecord
  def self.from_omniauth(auth)
    User.find_or_create_by(uid: auth.uid) do |u|
      u.email = auth.info.name
      u.auth_hash = auth
    end
  end
end
