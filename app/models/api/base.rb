module API
  class Base < JSONAPI::Consumer::Resource
    self.site = ENV['API_ROOT'] + 'v1/'

    class IncludeAuthId < Faraday::Middleware
      def call(env)
        env[:request_headers]['X-Auth-Id'] = Current.auth_id
        @app.call(env)
      end
    end

    connection do |conn|
      conn.use IncludeAuthId
      conn.use Faraday::Request::BasicAuthentication, 'dxw', ENV['API_PASSWORD'] if ENV['API_PASSWORD']
    end
  end
end
