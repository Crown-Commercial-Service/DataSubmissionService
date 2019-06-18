require 'rails_helper'

RSpec.feature 'Cancelling a correction submission' do
  around(:each) do |example|
    ClimateControl.modify CORRECTION_RETURNS_ENABLED: 'yes' do
      example.run
    end
  end

  context 'for a task with a correction in progress' do
    scenario 'it can be cancelled' do
      visit '/'

      mock_user_endpoint!
      mock_sso_with(email: 'email@example.com')
      mock_incomplete_tasks_endpoint!
      click_button 'sign-in'

      mock_correcting_task_with_framework_endpoint!
      click_link 'Cancel correction'
      mock_correcting_task_endpoint!
      mock_correction_cancellation = mock_correction_cancellation_endpoint!
      mock_correcting_task_with_framework_and_active_submission_endpoint!
      click_button 'Cancel correction'

      expect(mock_correction_cancellation).to have_been_requested
      expect(current_path).to eq(task_path('b847e0f7-027e-4b95-afa2-3490b8d05a1d'))
      expect(page).to have_content('You have successfully cancelled the correction.')
    end
  end

  context 'for a task that is not a correction' do
    it 'redirects to home page' do
      mock_task_with_framework_endpoint!

      visit cancel_correction_confirmation_task_path('2d98639e-5260-411f-a5ee-61847a2e067c')
      expect(current_path).to eq(root_path)
    end
  end
end
