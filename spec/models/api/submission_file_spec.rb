require 'rails_helper'

RSpec.describe API::SubmissionFile do
  # rubocop: disable Style/FormatStringToken
  it 'routes the resource’s base path to that defined on the API side' do
    expect(API::SubmissionFile.path).to eq 'submissions/%{submission_id}/files'
    expect(API::SubmissionFile.path(submission_id: '123')).to eq 'submissions/123/files'
  end
  # rubocop: enable Style/FormatStringToken
end
