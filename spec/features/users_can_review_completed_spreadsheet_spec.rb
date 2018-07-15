require 'rails_helper'

RSpec.feature 'User reviews completed spreadsheet' do
  feature 'Signed-in user with an upload spreadsheet' do
    before(:each) do
      mock_upload_task_submission_flow_endpoints!
      mock_update_task_endpoint!
      mock_submission_with_entries_validated_endpoint!
    end

    scenario 'can successfully review contents in the uploaded file' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_on 'Sign in'

      visit '/tasks'
      click_on 'Upload submission'

      expect(page).to have_content('Upload submission for CBOARD5')

      attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
      click_button 'Upload'

      expect(page).to have_content('Review your information')

      within '#invoices' do
        expect(page).to have_content('2')
      end

      within '#orders' do
        expect(page).to have_content('1')
      end
    end

    scenario 'and cancel/go back to re upload the spreadsheet' do
      mock_sso_with(email: 'email@example.com')

      visit '/'
      click_on 'Sign in'

      visit '/tasks'
      click_on 'Upload submission'

      expect(page).to have_content('Upload submission for CBOARD5')

      attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
      click_button 'Upload'

      expect(page).to have_content('Review your information')
      click_on 'submit another file'

      expect(page).to have_content('Upload submission for CBOARD5')
    end
  end
end
