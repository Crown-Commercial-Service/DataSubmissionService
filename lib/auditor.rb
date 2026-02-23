require 'uri'

class Auditor
  include HTTParty

  def self.normalized_api_root
    raw = ENV.fetch('API_ROOT')
    raw = "http://#{raw}" unless raw.match?(%r{\Ahttps?://})

    api_root = URI(raw)
    api_root.host = api_root.host.downcase if api_root.host

    api_root = api_root.to_s
    api_root += '/' unless api_root.end_with?('/')
    api_root
  end

  base_uri "#{normalized_api_root}v1/events"

  def user_signed_in(user_id:)
    self.class.post('/user_signed_in', query: { user_id: user_id })
  end

  def user_signed_out(user_id:)
    self.class.post('/user_signed_out', query: { user_id: user_id })
  end
end
