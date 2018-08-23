require 'rails_helper'

RSpec.describe 'the tasks list' do
  before do
    mock_tasks_endpoint!
  end

  it 'refuses users that are not signed in' do
    get tasks_path

    expect(response).to redirect_to(root_path)
  end

  context 'when signed-in' do
    before do
      stub_signed_in_user
      get tasks_path
    end

    it 'lists the supplier’s tasks' do
      expect(response).to be_successful
      expect(response.body).to include 'Unstarted task'
      expect(response.body).to include 'In review task (validated submission)'
      expect(response.body).to include 'Completed task'
    end

    it 'shows the tasks ordered by due date' do
      expect(response.body.index('7 September')).to be > response.body.index('7 August')
    end

    it 'shows completed tasks after other tasks' do
      expect(response.body.index('Completed task')).to be > response.body.index('In review task (validated submission)')
      expect(response.body.index('Completed task')).to be > response.body.index('Unstarted task')
    end

    it 'links to in-progress task submissions' do
      in_review_task_id = '855d1dd2-d9b3-4432-8c17-b63e90e50bcd'

      assert_select "#task-#{in_review_task_id}" do
        assert_select 'a', text: 'View submission status'
      end
    end

    it 'links to the template for a task’s framework' do
      cboard5_task_id = '2d98639e-5260-411f-a5ee-61847a2e067c'

      assert_select "#task-#{cboard5_task_id}" do
        assert_select 'a[href=?]', '/templates/CBOARD5 MISO Data Template (August 2018).xls', text: 'Download template'
      end
    end
  end
end
