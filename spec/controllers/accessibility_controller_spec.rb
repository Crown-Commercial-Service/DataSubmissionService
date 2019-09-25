require 'rails_helper'

RSpec.describe AccessibilityController do
  it 'allows a non-logged in user to access the page' do
    session[:auth_id] = nil

    get :index

    expect(response).to have_http_status(:ok)
  end
end
