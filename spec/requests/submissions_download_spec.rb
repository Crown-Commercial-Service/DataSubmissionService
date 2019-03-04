require 'rails_helper'

RSpec.describe 'downloading a submission' do
  it 'redirects the user to the S3 download link' do
    stub_signed_in_user

    mock_submission_with_file_endpoint!

    get download_task_submission_path(mock_task_id, mock_submission_id)

    expect(response.status).to eql 307
    expect(response).to redirect_to('http://s3.example.com/example.xls')
  end
end
