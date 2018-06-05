require 'rails_helper'

RSpec.feature 'Signing in as a user' do
  scenario 'Signing in successfully' do
    mock_sso_with(email: 'email@example.com')

    visit '/tasks'

    click_on 'Sign in'

    expect(page).to have_flash_message 'You are now signed in'
  end
end
