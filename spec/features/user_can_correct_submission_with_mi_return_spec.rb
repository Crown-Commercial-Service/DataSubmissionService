require 'rails_helper'

RSpec.feature 'Correcting a submission by reporting MI return' do
  around(:each) do |example|
    ClimateControl.modify CORRECTION_RETURNS_ENABLED: 'yes' do
      example.run
    end
  end

  context 'for a completed MI return submission' do
    scenario 'successfully, with a XLSX file' do
      visit '/'

      mock_user_endpoint!
      mock_sso_with(email: 'email@example.com')
      mock_task_with_framework_endpoint!
      mock_incomplete_tasks_endpoint!
      click_button 'sign-in'

      mock_complete_tasks_endpoint!
      click_link 'History'

      mock_completed_task_endpoint!
      click_link 'View'

      click_link 'Correct this return'
      expect(page).to have_content 'Cheese Board 5'
      expect(page).to have_content 'July 2018'
      expect(page).to_not have_content 'Bobs Cheese Shop'

      click_on 'Correct this return', exact: true
      expect(page).to have_content 'This is a correction'

      mock_create_submission = mock_create_submission_endpoint!
      mock_create_submission_file_endpoint!
      mock_create_submission_file_blob_endpoint!
      mock_submission_transitioning_to_in_review!
      mock_update_task_in_progress = mock_update_task_endpoint!
      mock_update_task_correcting = mock_update_task_endpoint!(status: 'correcting')
      attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
      click_button 'Upload'
      expect(page).to have_content 'This is a correction'
      expect(page).to have_content 'Checking file'

      expect(mock_create_submission.with(hash_including_correction)).to have_been_requested
      expect(mock_update_task_in_progress).to_not have_been_requested
      expect(mock_update_task_correcting).to have_been_requested

      visit page.current_url
      expect(page).to have_content 'Review & submit'
      expect(page).to have_content 'This is a correction'

      mock_submission_completed_with_task_endpoint!
      mock_complete_submission_endpoint!
      click_button 'Submit management information'
      expect(page).to have_content 'This is a correction'
    end

    scenario 'with validation failures'
  end

  context 'for a completed no business submission' do
    scenario 'successfully, with a XLSX file'
  end
end
