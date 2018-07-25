require 'rails_helper'

RSpec.describe API::Submission do
  include ApiHelpers
  describe '#orders_count' do
    let(:submission) { API::Submission.includes(:files, :entries).find('9a5ef62c-0781-4f80-8850-5793652b6b40').first }

    it 'returns the number of entries against sheets containing the word "order"' do
      mock_submission_with_entries_validated_endpoint!
      expect(submission.orders_count).to eq 1
    end
  end

  describe '#invoices_count' do
    let(:submission) { API::Submission.includes(:files, :entries).find('9a5ef62c-0781-4f80-8850-5793652b6b40').first }

    it 'returns the number of entries against sheets containing the word "invoice"' do
      mock_submission_with_entries_validated_endpoint!
      expect(submission.invoices_count).to eq 2
    end
  end

  describe '#errored_entries' do
    let(:submission) { API::Submission.includes(:files, :entries).find('9a5ef62c-0781-4f80-8850-5793652b6b40').first }

    it 'returns entries in an "errored" state' do
      mock_submission_with_entries_errored_endpoint!

      expect(submission.errored_entries.size).to eq 1
      expect(submission.errored_entries.first.status).to eq 'errored'
    end
  end
end
