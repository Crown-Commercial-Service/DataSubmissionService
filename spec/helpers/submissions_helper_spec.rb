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

  private

  def another_error
    { 'message' => 'Error 10', 'location' => { 'row' => 10, 'column' => 'Total' } }
  end
end
