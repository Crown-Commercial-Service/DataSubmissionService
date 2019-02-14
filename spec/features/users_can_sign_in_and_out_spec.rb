require 'rails_helper'

RSpec.feature 'Signing in and out as a user' do
  scenario 'Signing in successfully' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_user_endpoint!

    visit '/tasks'

    click_on 'sign-in'

    expect(page).to have_content 'Sign out'
  end

  scenario 'Signing in unsuccessfully' do
    mock_sso_failure(:invalid_credentials)

    visit '/tasks'

    click_on 'sign-in'

    expect(page).to have_content 'We were unable to sign you in with the provided credentials'
  end

  scenario 'Signing out successfully' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_user_endpoint!

    visit '/'
    click_on 'sign-in'

    visit '/'
    click_on 'Sign out'

    expect(page).to have_content 'Sign in'
  end
end
