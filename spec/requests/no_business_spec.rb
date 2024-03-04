require 'rails_helper'

RSpec.describe 'reporting no business' do
  before do
    mock_task_with_framework_endpoint!
    mock_no_business_endpoint!
    mock_notifications_endpoint!
    mock_user_endpoint!
  end

  it 'refuses users that are not signed in' do
    get new_task_no_business_path(task_id: mock_task_id)

    expect(response).to redirect_to(root_path)
  end

  describe 'the report no business page' do
    it 'asks the user to confirm they want to report no business' do
      stub_signed_in_user
      get new_task_no_business_path(task_id: mock_task_id)

      expect(response).to be_successful
      expect(response.body).to include 'Report no business'
    end
  end

  describe 'submitting no business' do
    it 'reports no business to the API and redirects the user to the resulting submission' do
      stub_signed_in_user
      post task_no_business_path(task_id: mock_task_id)

      expect(response)
        .to redirect_to(task_submission_path(task_id: mock_task_id, id: mock_submission_id))
    end
  end
end
