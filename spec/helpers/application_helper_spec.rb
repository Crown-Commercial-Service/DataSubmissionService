require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'task_month' do
    it 'returns the month-as-word for the reporting period of a task' do
      expect(helper.task_month(API::Task.new(period_year: 2018, period_month: 5))).to eq 'May'
      expect(helper.task_month(API::Task.new(period_year: 2018, period_month: 1))).to eq 'January'
    end
  end
end
