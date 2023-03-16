require 'rails_helper'

RSpec.feature 'Finding URN list' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_incomplete_tasks_endpoint!
    mock_user_endpoint!
  end

  scenario 'user looks for URN list' do
    visit '/'
    click_button 'sign-in'
    visit '/urns'

    expect(page).to have_content 'Unique Reference Number (URN) Lookup'
    expect(page).to have_content 'Need a URN? Download the URN list (opens in a new tab)'
  end
end