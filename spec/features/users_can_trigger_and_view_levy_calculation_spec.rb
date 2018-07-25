require 'rails_helper'

RSpec.feature 'User triggers and views levy calculation' do
  feature 'Signed-in user with an uploaded spreadsheet with validated entries' do
    before(:each) do
      mock_upload_task_submission_flow_endpoints!
      mock_update_task_endpoint!
    end

    scenario 'can successfully trigger levy calculation' do
      mock_submission_with_entries_validated_endpoint!
      mock_levy_calculate_endpoint!

      login_and_upload_file

      expect(page).to have_content('Review your information')

      click_link 'Continue'
      expect(page).to have_content('processing...')
    end

    scenario 'and successfully view levy calculation' do
      mock_submission_completed_endpoint!
      mock_levy_calculate_endpoint!

      login_and_upload_file

      expect(page).to have_content('Your Levy Calculation is: £ 4500')
    end
  end

  def login_and_upload_file
    mock_sso_with(email: 'email@example.com')

    visit '/'
    click_link 'sign-in'

    visit '/tasks'
    click_on 'Upload submission'

    expect(page).to have_content('Upload submission for CBOARD5')

    attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
    click_button 'Upload'
  end
end
