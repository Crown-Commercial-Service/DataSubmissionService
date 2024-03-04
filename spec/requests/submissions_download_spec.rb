require 'rails_helper'

RSpec.describe 'downloading a submission' do
  let(:fake_s3_client) { spy('Aws::S3::Client') }
  before do
    stub_signed_in_user
    allow_any_instance_of(SubmissionsController).to receive(:s3_client).and_return(fake_s3_client)
    mock_submission_with_file_endpoint!
    mock_notifications_endpoint!

    get download_task_submission_path(mock_task_id, mock_submission_id)
  end

  it 'downloads the submission file directly from S3 using the file_key in the API’s response' do
    expect(fake_s3_client).to have_received(:get_object).with(a_hash_including(key: '12345'))
    expect(response.header['Content-Type']).to eql('application/octet-stream')
  end
end
