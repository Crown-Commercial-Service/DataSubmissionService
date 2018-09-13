require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'levy_as_string' do
    it 'returns a pence levy as pounds' do
      expect(helper.levy_as_string(400)).to eq '£4.00'
      expect(helper.levy_as_string(553200)).to eq '£5,532.00'
      expect(helper.levy_as_string(12413555)).to eq '£124,135.55'
    end
  end

  describe 'task_month' do
    it 'returns the month-as-word for the reporting period of a task' do
      expect(helper.task_month(API::Task.new(period_year: 2018, period_month: 5))).to eq 'May'
      expect(helper.task_month(API::Task.new(period_year: 2018, period_month: 1))).to eq 'January'
    end
  end
end
