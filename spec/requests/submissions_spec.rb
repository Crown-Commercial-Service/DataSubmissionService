require 'rails_helper'

RSpec.describe 'the submission page' do
  let(:task_id) { '2d98639e-5260-411f-a5ee-61847a2e067c' }
  let(:submission_id) { '9a5ef62c-0781-4f80-8850-5793652b6b40' }

  before do
    stub_signed_in_user
    mock_task_with_framework_endpoint!
  end

  it 'shows the "processing" screen for a "pending" submission' do
    mock_pending_submission_endpoint!
    get task_submission_path(task_id: task_id, id: submission_id)

    expect(response).to be_successful
    expect(response.body).to include 'processing'
  end

  it 'shows the "processing" screen for a "processing submission' do
    mock_submission_with_entries_pending_endpoint!
    get task_submission_path(task_id: task_id, id: submission_id)

    expect(response).to be_successful
    expect(response.body).to include 'processing'
  end

  it 'shows the details for a valid "in_review" submission' do
    mock_submission_with_entries_validated_endpoint!
    get task_submission_path(task_id: task_id, id: submission_id)

    expect(response).to be_successful
    expect(response.body).to include 'Upload processed'
    expect(response.body).to include '£45.00'
  end

  it 'shows the errors for an invalid "in_review" submission' do
    mock_submission_with_entries_errored_endpoint!
    get task_submission_path(task_id: task_id, id: submission_id)

    expect(response).to be_successful
    expect(response.body).to include 'Upload processed'
    expect(response.body).to include 'Required value error'
    expect(response.body).to include 'Some other error'
  end

  it 'shows completed submission page for a "completed" submission' do
    mock_submission_completed_endpoint!
    get task_submission_path(task_id: task_id, id: submission_id)

    expect(response).to be_successful
    expect(response.body).to include 'Submission completed'
  end
end
