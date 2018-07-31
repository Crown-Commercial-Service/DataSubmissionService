require 'rails_helper'

RSpec.feature 'Managing tasks' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    visit '/'
    click_link 'sign-in'

    travel_to(Time.zone.local(2018, 7, 2))
  end

  after do
    travel_back
  end

  scenario 'viewing a list of tasks' do
    visit '/tasks'

    expect(page).to have_text 'Tasks'
    expect(page).to have_text 'Unstarted task'
  end

  scenario 'viewing the latest submission for an in-review task' do
    in_review_task_id = '855d1dd2-d9b3-4432-8c17-b63e90e50bcd'

    expect(page).to have_text 'In review task (validated submission)'

    within "#task-#{in_review_task_id}" do
      expect(page).to have_link 'View submission status'
    end
  end
end
