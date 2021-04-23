require 'rails_helper'

RSpec.feature 'Sorting completed tasks' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_incomplete_tasks_endpoint!
    mock_complete_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_no_business_correction_endpoint!
    mock_submission_completed_no_business_endpoint!

    mock_user_endpoint!
    visit '/'
    click_button 'sign-in'
    click_link 'Completed tasks'
  end

  context 'when viewing completed tasks' do
    let(:first_task_due_by) { 'July 2018' }
    let(:second_task_due_by) { 'August 2018' }

    scenario 'tasks are ordered by newest by default' do
      expect(second_task_due_by).to appear_before(first_task_due_by)
    end

    scenario 'tasks can be ordered by oldest using dropdown' do
      select('Oldest', from: 'order_by')
      find('#task-order-submit', visible: false).click

      expect(first_task_due_by).to appear_before(second_task_due_by)
    end

    scenario 'tasks can be ordered by newest using dropdown' do
      select('Newest', from: 'order_by')
      find('#task-order-submit', visible: false).click

      expect(second_task_due_by).to appear_before(first_task_due_by)
    end
  end
end
