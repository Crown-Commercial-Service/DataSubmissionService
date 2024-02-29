require 'rails_helper'

RSpec.feature 'User can see published notification' do
  scenario 'User signs in and sees the published notification' do
    mock_sso_with(email: 'email@example.com')
    mock_incomplete_tasks_endpoint!
    mock_user_endpoint!
    mock_notifications_endpoint!

    visit '/tasks'

    click_on 'sign-in'

    expect(page).to have_content 'Testy McTestface'
  end
end
