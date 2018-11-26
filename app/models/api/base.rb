module API
  class Base < JSONAPI::Consumer::Resource
    self.site = ENV['API_ROOT'] + 'v1/'
    connection do |conn|
      conn.use Faraday::Request::BasicAuthentication, 'dxw', ENV['API_PASSWORD'] if ENV['API_PASSWORD']
    end
  end
end
