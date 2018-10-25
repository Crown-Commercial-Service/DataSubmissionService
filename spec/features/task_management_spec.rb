require 'rails_helper'

RSpec.feature 'task management' do
  scenario 'user can upload and complete a valid submission' do
    travel_to Time.zone.local(2018, 7, 2)

    mock_sso_with(email: 'email@example.com')

    mock_upload_task_submission_flow_endpoints!

    visit '/'
    click_link 'start-now'

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
    mock_submission_completed_endpoint!

    click_on 'Submit management information'

    expect(page).to have_content 'submitted to CCS'
  end

  scenario 'user can upload an amended file' do
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_submission_errored_endpoint!

    visit '/'
    click_link 'start-now'

    visit task_submission_path(task_id: mock_task_id, id: mock_submission_id)

    expect(page).to have_content 'Errors to correct'

    click_on 'Upload amended file'

    expect(page).to have_content 'Choose a file'
  end

  private

  def force_reload_to_get_updated_submission_status
    visit current_path
  end

  def example_submission_file
    Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
  end
end
