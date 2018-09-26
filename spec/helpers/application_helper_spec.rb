require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'task_month' do
    it 'returns the month-as-word for the reporting period of a task' do
      expect(helper.task_month(API::Task.new(period_year: 2018, period_month: 5))).to eq 'May'
      expect(helper.task_month(API::Task.new(period_year: 2018, period_month: 1))).to eq 'January'
    end
  end

  describe '#framework_template_path_for' do
    let(:task) { double 'Task', framework: framework }

    subject { framework_template_path_for(task) }

    context 'Any non-slashy framework short name' do
      let(:framework) { double 'Framework', short_name: 'RM1234' }
      it { is_expected.to eql('/templates/RM1234 MISO Data Template (August 2018).xls') }
    end

    context 'frameworks with slashes in' do
      let(:framework) { double 'Framework', short_name: 'CM/OSG/05/3565' }
      it { is_expected.to eql('/templates/CM-OSG-05-3565 MISO Data Template (August 2018).xls') }
    end
  end
end
