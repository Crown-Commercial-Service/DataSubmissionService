require 'rails_helper'

RSpec.feature 'User uploads a file' do
  describe 'Signed-in user can upload a file' do
    scenario 'successfully, if the file has an xlsx or xlx content_type' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Sign in'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
        click_button 'Upload file'
      end.to change(ActiveStorage::Blob, :count).by(1)

      blob = ActiveStorage::Blob.last

      expect(current_path).to eq(tasks_path)
      expect(page).to have_content('upload successful')
      expect(page).to have_content(blob.filename)
    end

    scenario 'throws an error if the file does not have xlsx or xlx content_type' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Sign in'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.pdf')
        click_button 'Upload file'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(current_path).to eq(uploads_path)
      expect(page).to have_content('File content_type must be an xlsx or xlx')
    end

    scenario 'throws an error if no file was selected' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Sign in'

      expect do
        click_button 'Upload file'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content('Please select a file')
    end
  end
end
