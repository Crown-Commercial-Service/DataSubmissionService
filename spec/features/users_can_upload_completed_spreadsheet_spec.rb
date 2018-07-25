require 'rails_helper'

RSpec.feature 'User uploads completed spreadsheet' do
  describe 'Signed-in user can upload a completed spreadsheet' do
    before(:each) do
      mock_upload_task_submission_flow_endpoints!
      mock_submission_with_entries_pending_endpoint!
    end

    scenario 'successfully, if the file has an xlsx or xlx content_type' do
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

      expect(page).to have_content('upload successful')
      expect(page).to have_content(blob.filename)
    end

    scenario 'throws an error if the file does not have xlsx or xlx content_type' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_link 'sign-in'

      visit '/tasks'
      click_on 'Upload submission'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.pdf')
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content('File content_type must be an xlsx or xlx')
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

      expect(page).to have_content('Please select a file')
    end
  end
end
