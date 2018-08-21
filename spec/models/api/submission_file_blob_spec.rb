require 'rails_helper'

RSpec.describe API::SubmissionFileBlob do
  # rubocop: disable Style/FormatStringToken
  it 'routes the resource’s base path to that defined on the API side' do
    expect(API::SubmissionFileBlob.path).to eq 'files/%{file_id}/blobs'
    expect(API::SubmissionFileBlob.path(file_id: '456')).to eq 'files/456/blobs'
  end
  # rubocop: enable Style/FormatStringToken
end
