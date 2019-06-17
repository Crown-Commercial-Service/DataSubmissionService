module API
  class Base < JSONAPI::Consumer::Resource
    self.site = ENV['API_ROOT'] + 'v1/'

    class IncludeJWT < Faraday::Middleware
      def call(env)
        env[:request_headers]['Authorization'] = 'Bearer ' + Current.jwt if Current.jwt
        @app.call(env)
      end
    end

    connection do |conn|
      conn.use IncludeJWT
    end
  end
end
