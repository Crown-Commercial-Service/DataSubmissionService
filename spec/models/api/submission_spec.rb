require 'rails_helper'

RSpec.describe API::Submission do
  include ApiHelpers

  describe '#errored_entries' do
    let(:submission) { API::Submission.includes(:entries).find(mock_submission_id).first }

    it 'returns entries in an "errored" state' do
      mock_submission_with_entries_errored_endpoint!

      expect(submission.errored_entries.size).to eq 1
      expect(submission.errored_entries.first.status).to eq 'errored'
    end
  end
end
