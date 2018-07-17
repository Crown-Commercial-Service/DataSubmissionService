require 'rails_helper'

RSpec.feature 'Managing tasks' do
  scenario 'viewing a list of tasks' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!

    visit '/'
    click_on 'Sign in'

    Timecop.freeze(Time.zone.local(2018, 7, 2)) do
      visit '/tasks'
    end

    expect(page).to have_text 'Tasks'
    expect(page).to have_text 'First task'
  end
end
