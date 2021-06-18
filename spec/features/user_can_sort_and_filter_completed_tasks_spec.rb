require 'rails_helper'

RSpec.feature 'Sorting and filtering completed tasks' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_incomplete_tasks_endpoint!
    mock_complete_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_no_business_correction_endpoint!
    mock_submission_completed_no_business_endpoint!
    mock_filter_complete_tasks_endpoint!

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
      select('Month (oldest)', from: 'order_by').click
      find('#sort-and-filter-submit').click

      expect(first_task_due_by).to appear_before(second_task_due_by)
    end

    scenario 'tasks can be ordered by newest using dropdown' do
      select('Month (newest)', from: 'order_by')
      find('#sort-and-filter-submit').click

      expect(second_task_due_by).to appear_before(first_task_due_by)
    end

    scenario 'tasks can be filtered by framework' do
      expect(page).to have_content 'Apply filters'
      expect(page).to have_content 'Cheese Board 13 (cboard13)'
      expect(page).to have_content 'Cheese Board 5 (CBOARD5)'

      page.check('framework_id[]', match: :first)
      find('#sort-and-filter-submit').click
      mock_filter_complete_tasks = mock_filter_complete_tasks_endpoint!

      expect(mock_filter_complete_tasks).to have_been_requested
      expect(page).to have_content 'Displaying all 2 tasks'

      click_link('Clear filters')

      expect(page).to have_content 'Displaying all 3 tasks'
    end
  end
end
