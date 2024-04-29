require 'rails_helper'

RSpec.describe 'the submission page' do
  before do
    mock_task_with_framework_and_active_submission_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_user_endpoint!
    mock_notifications_endpoint!
  end

  it 'refuses users that are not signed in' do
    mock_submission_pending_endpoint!
    get task_submission_path(task_id: mock_task_id, id: mock_submission_id)

    expect(response).to redirect_to(root_path)
  end

  context 'when signed-in' do
    before { stub_signed_in_user }

    it 'shows the "processing" screen for a "pending" submission' do
      mock_submission_pending_endpoint!
      get task_submission_path(task_id: mock_task_id, id: mock_submission_id)

      expect(response).to be_successful
      expect(response.body).to include 'Checking file'
    end

    it 'shows the "processing" screen for a "processing" submission' do
      mock_submission_processing_endpoint!
      get task_submission_path(task_id: mock_task_id, id: mock_submission_id)

      expect(response).to be_successful
      expect(response.body).to include 'Checking file'
    end

    it 'shows the details for a valid submission' do
      mock_submission_validated_endpoint!
      get task_submission_path(task_id: mock_task_id, id: mock_submission_id)

      expect(response).to be_successful
      expect(response.body).to include 'Review & submit'
    end

    it 'shows the errors for an invalid submission' do
      mock_submission_errored_endpoint!
      mock_user_endpoint!
      get task_submission_path(task_id: mock_task_id, id: mock_submission_id)

      expect(response).to be_successful
      expect(response.body).to include 'Errors to correct'
      expect(response.body).to include 'You must enter a valid URN'
      expect(response.body).to include 'Enter value, without commas or pound signs'
    end

    it 'displays the 500 page for a submission that failed management charge calculation' do
      mock_submission_management_charge_calculation_failed_endpoint!
      get task_submission_path(task_id: mock_task_id, id: mock_submission_id)

      expect(response).to have_http_status(500)
      expect(response.body).to include 'Sorry, there is a problem with the service'
    end

    it 'shows completed submission page for a "completed" submission' do
      mock_submission_completed_no_business_endpoint!
      mock_user_endpoint!
      get task_submission_path(task_id: mock_task_id, id: mock_submission_id)

      expect(response).to be_successful
      expect(response.body).to include 'Thank you for reporting no business for'
    end
  end
end
