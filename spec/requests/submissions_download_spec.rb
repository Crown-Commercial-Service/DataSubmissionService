require 'rails_helper'

RSpec.describe 'downloading a submission' do
  it 'redirects the user to the S3 download link' do
    stub_signed_in_user

    mock_submission_with_file_endpoint!

    get download_task_submission_path(mock_task_id, mock_submission_id)

    expect(response.body).to eq('')
    expect(response.header['Content-Type']).to eql('application/octet-stream')
  end
end
