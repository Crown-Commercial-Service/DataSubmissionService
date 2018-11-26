require 'rails_helper'

RSpec.feature 'Signing in as a user' do
  scenario 'Signing in successfully' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_user_endpoint!

    visit '/tasks'

    click_on 'start-now'

    expect(page).to have_content 'Sign out'
  end

  scenario 'Signing out' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_user_endpoint!

    visit '/'
    click_on 'start-now'

    visit '/'
    click_on 'Sign out'

    expect(page).to have_content 'Sign in'
  end
end
