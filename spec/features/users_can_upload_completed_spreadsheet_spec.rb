require 'rails_helper'

RSpec.feature 'User uploads completed spreadsheet' do
  describe 'Signed-in user can upload a completed spreadsheet' do
    before(:each) do
      mock_upload_task_submission_flow_endpoints!
      mock_submission_with_entries_pending_endpoint!
    end

    scenario 'successfully, with a XLSX file' do
      mock_sso_with(email: 'email@example.com')

      mock_update_task_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Upload submission'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      blob = ActiveStorage::Blob.last

      expect(page).to have_flash_message "#{blob.filename} was successfully uploaded"
      expect(page).to have_content 'processing'
    end

    scenario 'successfully, with a XLS file' do
      mock_sso_with(email: 'email@example.com')

      mock_update_task_endpoint!

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Upload submission'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xls')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      blob = ActiveStorage::Blob.last

      expect(page).to have_flash_message "#{blob.filename} was successfully uploaded"
      expect(page).to have_content 'processing'
    end

    scenario 'throws an error if the file is not one of the expected formats' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Upload submission'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.pdf')
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_flash_message 'Uploaded file must be in Microsoft Excel format (either .xlsx or .xls)'
    end

    scenario 'throws an error if no file was selected' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Upload submission'

      expect do
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_flash_message 'Please select a file'
    end
  end
end
