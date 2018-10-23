require 'rails_helper'

RSpec.feature 'User uploads completed spreadsheet' do
  describe 'Signed-in user can upload a completed spreadsheet' do
    before(:each) do
      mock_upload_task_submission_flow_endpoints!
      mock_submission_processing_endpoint!
    end

    scenario 'successfully, with a XLSX file' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_link 'start-now'

      visit '/tasks'
      click_on 'Report management information'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      expect(page).to have_content 'Checking file'
    end

    scenario 'successfully, with a XLS file' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_link 'start-now'

      visit '/tasks'
      click_on 'Report management information'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xls')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      expect(page).to have_content 'Checking file'
    end

    scenario 'throws an error if the file is not one of the expected formats' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_link 'start-now'

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

      visit '/'
      click_link 'start-now'

      visit '/tasks'
      click_on 'Report management information'

      expect do
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content 'Please select a file'
    end
  end
end
