require 'rails_helper'

RSpec.feature 'task management' do
  scenario 'user can upload and complete a valid submission' do
    travel_to Time.zone.local(2018, 7, 2)

    mock_sso_with(email: 'email@example.com')

    mock_upload_task_submission_flow_endpoints!
    mock_user_endpoint!

    visit '/'
    click_link 'sign-in'

    visit '/tasks'

    expect(page).to have_content 'CBOARD5'

    click_on 'Report management information'

    expect(page).to have_content 'Choose a file'

    attach_file :upload, example_submission_file

    expect { click_button 'Upload' }.to change(ActiveStorage::Blob, :count).by(1)

    expect(page).to have_content 'Checking file'

    force_reload_to_get_updated_submission_status

    expect(page).to have_content 'Review & submit'

    mock_complete_submission_endpoint!
    mock_submission_completed_with_task_endpoint!
    mock_submission_completed_report_mi_endpoint!

    click_on 'Submit management information'

    expect(page).to have_content 'Thank you for reporting your management information for'
  end

  scenario 'user can upload an amended file' do
    mock_sso_with(email: 'email@example.com')
    mock_user_endpoint!
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_submission_errored_endpoint!

    visit '/'
    click_link 'sign-in'

    visit task_submission_path(task_id: mock_task_id, id: mock_submission_id)

    expect(page).to have_content 'Errors to correct'

    click_on 'Upload amended file'

    expect(page).to have_content 'Choose a file'
  end

  scenario 'see the current supplier name on a task when linked to multiple suppliers' do
    travel_to Time.zone.local(2018, 7, 2)

    mock_sso_with(email: 'email@example.com')

    mock_upload_task_submission_flow_endpoints!
    mock_user_with_multiple_suppliers_endpoint!

    visit '/'
    click_link 'sign-in'

    visit '/tasks'

    expect(page).to have_content 'CBOARD5'

    expect(page).to have_content 'Bobs Cheese Shop'
  end

  private

  def force_reload_to_get_updated_submission_status
    visit current_path
  end

  def example_submission_file
    Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
  end
end
