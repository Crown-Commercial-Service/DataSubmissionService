require 'rails_helper'

RSpec.feature 'User can access a page' do
  scenario 'with support information.' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!

    visit '/'
    click_link 'sign-in'

    visit '/support'
    expect(page).to have_content('Support')
  end
end
