require 'rails_helper'

RSpec.describe API::Task do
  include ApiHelpers

  describe '#safe_short_name' do
    it 'sanitizes the short name' do
      mock_task_with_unsafe_short_name_framework_endpoint!
      task = API::Task.includes(:framework).find(mock_task_id).first
      framework = task.framework
      expect(framework.safe_short_name).to eq('CBOARD-5')
    end
  end
end
