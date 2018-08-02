require 'rails_helper'

RSpec.describe 'the tasks list' do
  before do
    stub_signed_in_user
    mock_tasks_endpoint!
    get tasks_path
  end

  it 'lists the supplier’s tasks' do
    expect(response).to be_successful
    expect(response.body).to include 'Unstarted task'
    expect(response.body).to include 'In review task (validated submission)'
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
      assert_select 'a[href=?]', '/templates/CBOARD5 MISO Data Template (July 2018).xls', text: 'Download template'
    end
  end
end
