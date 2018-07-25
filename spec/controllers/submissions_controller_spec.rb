require 'rails_helper'

RSpec.describe SubmissionsController do
  include ApiHelpers

  render_views

  let(:email) { 'email@example.com' }
  let(:user) { FactoryBot.create(:user) }

  before do
    allow_any_instance_of(SubmissionsController).to receive(:current_user).and_return(user)
  end

  describe '#show' do
    before { mock_task_with_framework_endpoint! }

    context ' with a "pending" submission' do
      before do
        mock_pending_submission_endpoint!
        get :show, params: {
          task_id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40'
        }
      end

      it 'shows the "processing" screen' do
        expect(response).to be_successful
        expect(response.body).to have_content 'processing'
      end
    end

    context 'with a "processing" submission' do
      before do
        mock_submission_with_entries_pending_endpoint!
        get :show, params: {
          task_id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40'
        }
      end

      it 'shows the "processing" screen' do
        expect(response).to be_successful
        expect(response.body).to have_content 'processing'
      end
    end

    context 'with an "in_review" submission that has validated' do
      before do
        mock_submission_with_entries_validated_endpoint!
        get :show, params: {
          task_id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40'
        }
      end

      it 'shows the details for the submission, including a button to complete it' do
        expect(response).to be_successful
        expect(response.body).to have_content('Upload processed')
        expect(response.body).to have_content('£4,500')
        expect(response.body).to have_css 'input[type="submit"][value="Complete submission"]'
      end
    end

    context 'with an "in_review" submission that has errors' do
      before do
        mock_submission_with_entries_errored_endpoint!
        get :show, params: {
          task_id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40'
        }
      end

      it 'shows the errors for the submission, and no button to complete it' do
        expect(response).to be_successful
        expect(response.body).to have_content('Upload processed')
        expect(response.body).to have_content('Required value error')
        expect(response.body).not_to have_css 'input[type="submit"][value="Complete submission"]'
      end
    end

    context 'with a "completed" submission' do
      before do
        mock_submission_completed_endpoint!
        get :show, params: {
          task_id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40'
        }
      end

      it 'shows completed submission page' do
        expect(response).to be_successful
        expect(response.body).to have_content('Submission completed')
      end
    end
  end
end
