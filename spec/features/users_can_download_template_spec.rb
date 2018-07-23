require 'rails_helper'

RSpec.feature 'User downloads a template' do
  scenario 'successfully from a task\'s list' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!

    visit '/'
    click_on 'Sign in'

    visit '/tasks'
    expect(page).to have_link('Download template', href: '/templates/CBOARD5 MISO Data Template (July 2018).xls')
  end
end
