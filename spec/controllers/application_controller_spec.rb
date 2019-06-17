require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#ensure_user_signed_in' do
    controller do
      before_action :ensure_user_signed_in

      def index
        render inline: 'hello'
      end
    end

    it 'allows signed in users to access' do
      session[:jwt] = fake_json_web_token

      get :index

      expect(response).to have_http_status(:ok)
    end

    it 'redirects guest users to the home page' do
      get :index

      expect(response).to redirect_to(root_path)
    end
  end

  private

  def fake_json_web_token
    payload = {
      name: 'test@example.com',
      iss: 'https://auth0.fake',
      sub: 'auth0|123456789',
      iat: Time.zone.now.to_i,
      exp: 10.hours.from_now.to_i
    }

    private_key = OpenSSL::PKey.read(File.read(Rails.root.join('spec', 'fixtures', 'jwtRS256.key')))
    JWT.encode(payload, private_key, 'RS256')
  end
end
