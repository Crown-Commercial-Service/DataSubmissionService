require 'rails_helper'

RSpec.feature 'User confirms submission and complete task' do
  feature 'Signed-in user with a completed submission and levy' do
    before(:each) do
      mock_upload_task_submission_flow_endpoints!
      mock_update_task_endpoint!
      mock_submission_completed_endpoint!
      mock_levy_calculate_endpoint!

      mock_task_complete_endpoint!
      mock_update_submission_endpoint!
    end

    scenario 'can confirm submission and complete task' do
      login_and_upload_file

      expect(page).to have_content('Review your information')
      expect(page).to have_content('Your Levy Calculation is: £ 4500')

      click_button 'Confirm'
      expect(page).to have_content('Submission completed')
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
