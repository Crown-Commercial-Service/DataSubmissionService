require 'rails_helper'

RSpec.feature 'User uploads completed spreadsheet' do
  describe 'Signed-in user can upload a completed spreadsheet' do
    before(:each) do
      mock_upload_task_submission_flow_endpoints!
      mock_submission_processing_endpoint!
      mock_user_endpoint!
    end

    scenario 'successfully, with a XLSX file' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Report management information'

      expect(page).to_not have_content 'This is a correction'
      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      expect(page).to have_content 'Checking file'
    end

    scenario 'successfully, with a XLS file' do
      mock_sso_with(email: 'email@example.com')
      mock_user_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Report management information'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xls')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      expect(page).to have_content 'Checking file'
    end

    scenario 'successfully and sees the current supplier name' do
      travel_to Time.zone.local(2018, 7, 2)

      mock_sso_with(email: 'email@example.com')
      mock_upload_task_submission_flow_endpoints!
      mock_submission_processing_endpoint!
      mock_user_with_multiple_suppliers_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks'

      expect(page).to have_content 'CBOARD5'
      expect(page).to have_content 'Bobs Cheese Shop'

      click_on 'Report management information'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      expect(page).to have_content 'Checking file'

      expect(page).to have_content 'Report management information'
      expect(page).to have_content 'Bobs Cheese Shop'
    end

    scenario 'throws an error if the file is not one of the expected formats' do
      mock_sso_with(email: 'email@example.com')
      mock_user_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Report management information'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.pdf')
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content 'Uploaded file must be in Microsoft Excel format (either .xlsx or .xls)'
    end

    scenario 'throws an error if no file was selected' do
      mock_sso_with(email: 'email@example.com')
      mock_user_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Report management information'

      expect do
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content 'Please select a file'
    end

    scenario 'see the current supplier name on the review view' do
      travel_to Time.zone.local(2018, 7, 2)

      mock_sso_with(email: 'email@example.com')
      mock_upload_task_submission_flow_endpoints!
      mock_submission_validated_endpoint!
      mock_user_with_multiple_suppliers_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks/2d98639e-5260-411f-a5ee-61847a2e067c/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40'

      expect(page).to have_content 'CBOARD5'
      expect(page).to have_content 'Bobs Cheese Shop'
    end

    scenario 'see the current supplier name on the complete view' do
      travel_to Time.zone.local(2018, 7, 2)

      mock_sso_with(email: 'email@example.com')
      mock_upload_task_submission_flow_endpoints!
      mock_submission_validated_endpoint!
      mock_user_with_multiple_suppliers_endpoint!
      mock_submission_completed_with_task_endpoint!
      mock_complete_submission_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks/2d98639e-5260-411f-a5ee-61847a2e067c/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40'

      click_button 'Submit management information'

      expect(page).to have_content 'CBOARD5'
      expect(page).to have_content 'Bobs Cheese Shop'
    end
  end
end
