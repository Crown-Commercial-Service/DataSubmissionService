require 'rails_helper'

RSpec.describe 'the tasks list' do
  it 'refuses users that are not signed in' do
    get tasks_path

    expect(response).to redirect_to(root_path)
  end

  context 'when signed-in as a user with tasks' do
    before do
      mock_tasks_endpoint!
      mock_user_endpoint!
      stub_signed_in_user
      get tasks_path
    end

    it 'lists the supplier’s tasks' do
      expect(response).to be_successful
      expect(response.body).to include 'CBOARD5'
      expect(response.body).to include 'cboard11'
      expect(response.body).to include 'cboard13'
    end

    it 'shows the tasks ordered by due date' do
      expect(response.body.index('7 September')).to be > response.body.index('7 August')
    end

    it 'shows completed tasks after other tasks' do
      expect(response.body.index('cboard13')).to be > response.body.index('CBOARD5')
      expect(response.body.index('cboard13')).to be > response.body.index('cboard11')
    end

    it 'includes links to start an unstarted task' do
      unstarted_task_id = '2d98639e-5260-411f-a5ee-61847a2e067c'

      assert_select "#task-#{unstarted_task_id}" do
        assert_select 'a', text: 'Report management information'
        assert_select 'a', text: 'Report no business'
      end
    end

    it 'includes links to review a validated submission' do
      in_review_task_id = '855d1dd2-d9b3-4432-8c17-b63e90e50bcd'

      assert_select "#task-#{in_review_task_id}" do
        assert_select 'a', text: 'Submit management information'
      end
    end

    it 'includes links to view or amend a failed submission' do
      errored_task_id = 'b847e0f7-027e-4b95-afa2-3490b8d05a1c'

      assert_select "#task-#{errored_task_id}" do
        assert_select 'a', text: 'View errors'
        assert_select 'a', text: 'Upload amended file'
      end
    end

    it 'includes a link to view the latest pending submission' do
      in_progress_task_id = 'fc9deeb0-9804-42f7-ad8b-8b9878cce252'

      assert_select "#task-#{in_progress_task_id}" do
        assert_select 'a', text: 'View progress'
      end
    end

    it 'includes a link to view the latest processing submission' do
      processing_task_id = 'd211060f-e4fa-413a-928e-5928d0083db6'

      assert_select "#task-#{processing_task_id}" do
        assert_select 'a', text: 'View progress'
      end
    end

    it 'links to the template for a task’s framework' do
      cboard5_task_id = '2d98639e-5260-411f-a5ee-61847a2e067c'

      assert_select "#task-#{cboard5_task_id}" do
        assert_select 'a[href=?]',
                      task_template_path(cboard5_task_id),
                      text: 'Download template'
      end
    end
  end

  context 'when signed-in as a user with no tasks' do
    before do
      mock_empty_tasks_endpoint!
      stub_signed_in_user
      get tasks_path
    end

    it 'tells the user they have no tasks_path' do
      expect(response.body).to include 'All your tasks are complete.'
    end
  end
end
