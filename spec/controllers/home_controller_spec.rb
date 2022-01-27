require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET cookie_policy' do
    it 'renders the cookie policy page' do
      get :cookie_policy
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET cookie_settings' do
    it 'renders the cookie settings page' do
      get :cookie_settings
      expect(response).to have_http_status(:ok)
    end
  end
end
