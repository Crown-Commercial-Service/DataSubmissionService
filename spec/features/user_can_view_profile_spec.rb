require 'rails_helper'

RSpec.feature 'User can view profile' do
  scenario 'User visits the release notes page' do
    mock_sso_with(email: 'email@example.com')
    mock_user_with_multiple_suppliers_endpoint!
    mock_notifications_endpoint!
    mock_suppliers_endpoint!

    visit '/'
    click_button 'sign-in'

    visit '/user_detail'

    expect(page).to have_content 'Name User Name'
    expect(page).to have_content 'Email user@example.com'
    expect(page).to have_content 'User since 1 October 2023'
  end
end
