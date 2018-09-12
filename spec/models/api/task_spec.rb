require 'rails_helper'

RSpec.describe API::Task do
  include ApiHelpers

  describe '#complete?' do
    it 'returns true if the task is in a completed state' do
      expect(API::Task.new(status: 'completed')).to be_complete
      expect(API::Task.new(status: 'unstarted')).not_to be_complete
    end
  end

  describe '#errors?' do
    it 'returns true if the latest submission is errored' do
      mock_task_with_invalid_submission_endpoint!
      task_with_invalid_submission = API::Task.includes(:latest_submission).find(mock_task_id).first

      expect(task_with_invalid_submission.errors?).to be_truthy
    end

    it 'returns false if the latest submission is not errored' do
      mock_task_with_valid_submission_endpoint!
      task_with_valid_submission = API::Task.includes(:latest_submission).find(mock_task_id).first

      expect(task_with_valid_submission.errors?).to be_falsy
    end

    it 'doesn’t fall over if the task doesn’t have a submission' do
      mock_task_with_framework_endpoint!
      task_without_submission = API::Task.includes(:framework).find(mock_task_id).first

      expect(task_without_submission.errors?).to be_falsy
    end
  end

  describe '#late?' do
    it 'returns true if the due date has passed' do
      expect(API::Task.new(due_on: '2018-08-07')).to be_late
      expect(API::Task.new(due_on: '2030-08-07')).not_to be_late
    end

    it 'returns false for a completed task' do
      expect(API::Task.new(status: 'completed', due_on: '2018-08-07')).not_to be_late
    end
  end
end
