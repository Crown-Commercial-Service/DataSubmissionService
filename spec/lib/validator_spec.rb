require 'rails_helper'

RSpec.describe Validator do
  describe '.status' do
    let(:subject) { described_class.new(submission_entries: double(:submission_entries)) }
    let(:result) { subject.status }
    it 'returns validated status' do
      allow(subject).to receive(:validated?).and_return(true)
      allow(subject).to receive(:errored?).and_return(false)
      expect(result).to eq('validated')
    end

    it 'returns errored status' do
      allow(subject).to receive(:validated?).and_return(false)
      allow(subject).to receive(:errored?).and_return(true)
      expect(result).to eq('errored')
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

    let(:submission_entries) { double(:submission_entries, validation_errors: errors) }
    let(:subject) { described_class.new(submission_entries: submission_entries) }
    let(:result) { subject.errors }

    it 'returns validation errors' do
      allow(subject).to receive(:errored?).and_return(true)

      allow(submission_entries).to receive(:map) { |arg|
        allow(arg).to receive(:validation_errors)
      }.and_return(errors)

      expect(result).to eq(errors)
    end
  end
end
