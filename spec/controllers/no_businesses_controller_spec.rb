require 'rails_helper'

RSpec.describe NoBusinessesController, type: :controller do
  include ApiHelpers

  render_views

  let(:user) { FactoryBot.create(:user) }
  let(:task_id) { '2d98639e-5260-411f-a5ee-61847a2e067c' }
  let(:submission_id) { '9a5ef62c-0781-4f80-8850-5793652b6b40' }

  before do
    allow_any_instance_of(SubmissionsController).to receive(:current_user).and_return(user)
    mock_task_with_framework_endpoint!
    mock_no_business_endpoint!
  end

  describe 'GET #new' do
    it 'asks the user to confirm they want to report no business' do
      get :new, params: { task_id: task_id }
      expect(response).to be_successful
      expect(response.body).to have_content 'Report no business'
    end
  end

  describe 'POST #create' do
    it 'reports no business to the API and redirects the user to the resulting submission' do
      post :create, params: { task_id: task_id }

      expect(response)
        .to redirect_to(task_submission_path(task_id: '2d98639e-5260-411f-a5ee-61847a2e067c', id: submission_id))
    end
  end
end
