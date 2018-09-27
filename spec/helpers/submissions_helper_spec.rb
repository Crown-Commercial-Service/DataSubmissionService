require 'rails_helper'

RSpec.describe SubmissionsHelper do
  describe '#potentially_truncated_errors' do
    let(:submission) do
      API::Submission.new(
        sheet_errors: {
          'Sheet 1' => [
            { 'message' => 'Error 1', 'location' => { 'row' => 1, 'column' => 'Total' } },
            { 'message' => 'Error 2', 'location' => { 'row' => 2, 'column' => 'Total' } },
            { 'message' => 'Error 3', 'location' => { 'row' => 3, 'column' => 'Total' } },
            { 'message' => 'Error 4', 'location' => { 'row' => 4, 'column' => 'Total' } },
            { 'message' => 'Error 5', 'location' => { 'row' => 5, 'column' => 'Total' } },
            { 'message' => 'Error 6', 'location' => { 'row' => 6, 'column' => 'Total' } },
            { 'message' => 'Error 7', 'location' => { 'row' => 7, 'column' => 'Total' } },
            { 'message' => 'Error 8', 'location' => { 'row' => 8, 'column' => 'Total' } },
            { 'message' => 'Error 9', 'location' => { 'row' => 9, 'column' => 'Total' } },
          ],
          'Sheet 2' => [
            { 'message' => 'Error 1', 'location' => { 'row' => 1, 'column' => 'Total' } },
          ]
        }
      )
    end

    it 'returns true for submissions that have 10 or more errors on a given sheet' do
      expect(helper.potentially_truncated_errors(submission)).to eq false

      submission.sheet_errors['Sheet 1'] << another_error
      expect(helper.potentially_truncated_errors(submission)).to eq true

      submission.sheet_errors['Sheet 1'] << another_error
      expect(helper.potentially_truncated_errors(submission)).to eq true
    end
  end

  describe '#submission_completed_text' do
    before { mock_task_with_framework_endpoint! }

    context 'given a task without a description' do
      let(:task) { API::Task.includes(:framework).find(mock_task_id).first }

      it 'includes the task name and shortname in the message' do
        expect(helper.submission_completed_text(task))
          .to eql 'Management information for CBOARD5 Cheese Board 5 submitted to CCS'
      end
    end

    context 'given a task with a description' do
      let(:task) do
        API::Task.includes(:framework).find(mock_task_id).first.tap do |task|
          allow(task).to receive(:description).and_return('Company Name')
        end
      end

      it 'prefixes the messaage with the description with appropriate capitalisation' do
        expect(helper.submission_completed_text(task))
          .to eql 'Company Name management information for CBOARD5 Cheese Board 5 submitted to CCS'
      end
    end
  end

  private

  def another_error
    { 'message' => 'Error 10', 'location' => { 'row' => 10, 'column' => 'Total' } }
  end
end
