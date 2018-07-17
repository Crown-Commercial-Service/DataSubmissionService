require 'rails_helper'

RSpec.describe Validator do
  describe '.status' do
    it 'returns validated status' do
      entries = [double('SubmissionEntry', status: 'validated'),
                 double('SubmissionEntry', status: 'validated')]
      submission = instance_double('Submission', entries: entries, status: 'processing')
      subject = described_class.new(submission: submission)
      result = subject.status

      expect(result).to eq('validated')
    end

    it 'returns errored status' do
      entries = [double('SubmissionEntry', status: 'errored'),
                 double('SubmissionEntry', status: 'validated')]
      submission = instance_double('Submission', entries: entries, status: 'processing')
      subject = described_class.new(submission: submission)
      result = subject.status

      expect(result).to eq('errored')
    end

    it 'returns levy_completed status' do
      entries = [double('SubmissionEntry', status: 'validated'),
                 double('SubmissionEntry', status: 'validated')]
      submission = instance_double('Submission', entries: entries, status: 'completed')
      subject = described_class.new(submission: submission)
      result = subject.status

      expect(result).to eq('levy_completed')
    end
  end

  describe '.errors' do
    let(:errors) do
      [
        validation_errors: {
          location: {
            row: 20,
            column: 2
          },
          message: 'Required value error'
        }
      ]
    end

    let(:entries) do
      [
        double('SubmissionEntry', status: 'errored', validation_errors: errors),
        double('SubmissionEntry', status: 'validated', validation_errors: nil)
      ]
    end
    let(:submission) { instance_double('Submission', entries: entries, status: 'processing') }

    it 'returns validation errors' do
      subject = described_class.new(submission: submission)
      result = subject.errors
      expect(result).to eq(errors)
    end
  end

  describe '.pending' do
    it 'returns true if any entry has a pending status' do
      entries = [double('SubmissionEntry', status: 'pending'),
                 double('SubmissionEntry', status: 'validated')]
      submission = instance_double('Submission', entries: entries, status: 'processing')
      subject = described_class.new(submission: submission)
      expect(subject.pending?).to eq(true)
    end
  end
end
