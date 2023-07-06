require 'rails_helper'

RSpec.feature 'Finding URN list' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_incomplete_tasks_endpoint!
    mock_user_endpoint!
    mock_customers_endpoint!
  end

  scenario 'user looks for URN list' do
    visit '/'
    click_button 'sign-in'
    visit '/urns'

    expect(page).to have_content 'URN list'
    expect(page).to have_content 'You can search for URNs below or go to this page to download a list'
    expect(page).to have_content 'Search and check URNs'
    expect(page).to have_content 'URN Organisation name Sector Postcode'
  end
end
