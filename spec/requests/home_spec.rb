require 'rails_helper'

RSpec.describe 'the home page' do
  it 'shows introductory text for non-signed in users' do
    get root_path

    expect(response.body).to include 'If you’re having trouble signing in'
  end

  it 'links to the user’s task list when signed in' do
    stub_signed_in_user
    mock_notifications_endpoint!
    get root_path

    expect(response).to redirect_to(tasks_path)
  end

  # describe 'POST /auth/:provider without CSRF token' do
  #   before do
  #     @allow_forgery_protection = ActionController::Base.allow_forgery_protection
  #     ActionController::Base.allow_forgery_protection = true
  #   end

  #   it do
  #     expect do
  #       post '/auth/auth0'
  #     end.to raise_error(ActionController::InvalidAuthenticityToken)
  #   end

  #   after do
  #     ActionController::Base.allow_forgery_protection = @allow_forgery_protection
  #   end
  # end
end
