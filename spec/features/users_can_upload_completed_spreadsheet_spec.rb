require 'rails_helper'

RSpec.feature 'User uploads completed spreadsheet' do
  describe 'Signed-in user can upload a completed spreadsheet' do
    scenario 'successfully, if the file has an xlsx or xlx content_type' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Sign in'

      click_on I18n.t('tasks.index.completed_return')

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
        click_button 'Upload file'
      end.to change(ActiveStorage::Blob, :count).by(1)

      blob = ActiveStorage::Blob.last

      expect(current_path).to eq(upload_review_task_path(id: temp_task_id))
      expect(page).to have_content('upload successful')
      expect(page).to have_content(blob.filename)
      expect(page).to have_content(I18n.t('uploads.review.heading'))
      expect(page).to have_link(I18n.t('uploads.review.submit'))
    end

    scenario 'throws an error if the file does not have xlsx or xlx content_type' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Sign in'

      click_on I18n.t('tasks.index.completed_return')

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

      click_on I18n.t('tasks.index.completed_return')

      expect do
        click_button 'Upload file'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content('Please select a file')
    end
  end
end
