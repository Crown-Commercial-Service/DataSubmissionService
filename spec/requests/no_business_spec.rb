require 'rails_helper'

RSpec.describe 'reporting no business' do
  let(:task_id) { '2d98639e-5260-411f-a5ee-61847a2e067c' }
  let(:submission_id) { '9a5ef62c-0781-4f80-8850-5793652b6b40' }

  before do
    stub_signed_in_user
    mock_task_with_framework_endpoint!
  end

  describe 'the report no business page' do
    it 'asks the user to confirm they want to report no business' do
      get new_task_no_business_path(task_id: task_id)

      expect(response).to be_successful
      expect(response.body).to include 'Report no business'
    end
  end

  describe 'submitting no business' do
    it 'reports no business to the API and redirects the user to the resulting submission' do
      mock_no_business_endpoint!
      post task_no_business_path(task_id: task_id)

      expect(response)
        .to redirect_to(task_submission_path(task_id: task_id, id: submission_id))
    end
  end
end
