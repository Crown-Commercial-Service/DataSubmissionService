require 'rails_helper'

RSpec.describe 'the tasks list' do
  it 'refuses users that are not signed in' do
    get tasks_path

    expect(response).to redirect_to(root_path)
  end

  context 'when signed-in as a user with tasks' do
    before do
      mock_incomplete_tasks_endpoint!
      mock_user_endpoint!
      mock_notifications_endpoint!
      stub_signed_in_user
      get tasks_path
    end

    it 'lists the supplier’s tasks' do
      expect(response).to be_successful
      expect(response.body).to include 'CBOARD5'
      expect(response.body).to include 'cboard11'
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
        assert_select 'a', text: 'Review and submit'
      end
    end

    it 'includes links to view or amend a validation_failed submission' do
      errored_task_id = 'b847e0f7-027e-4b95-afa2-3490b8d05a1c'

      assert_select "#task-#{errored_task_id}" do
        assert_select 'a', text: 'View and correct errors'
      end
    end

    it 'includes links to view or amend a management_charge_calculation_failed submission' do
      errored_task_id = 'b847e0f7-027e-4b95-afa2-3490b8d05a1e'

      assert_select "#task-#{errored_task_id}" do
        assert_select 'a', text: 'View and correct errors'
      end
    end

    it 'links to the template for a task’s framework' do
      cboard5_task_id = '2d98639e-5260-411f-a5ee-61847a2e067c'

      assert_select "#task-#{cboard5_task_id}" do
        assert_select 'a[href=?]',
                      template_path(id: cboard5_task_id),
                      text: 'Download template (excel document)'
      end
    end

    it 'lists a task with an incomplete correction' do
      correcting_task_id = 'b847e0f7-027e-4b95-afa2-3490b8d05a1d'
      correcting_submission_id = '43dfbd10-1c17-4f3c-8665-be8c27762923'

      assert_select "#task-#{correcting_task_id}" do
        assert_select '.govuk-tag__notice', text: 'Correction'
        assert_select '.govuk-tag.govuk-tag__failure', text: 'Errors'
        assert_select 'a[href=?]',
                      task_submission_path(task_id: correcting_task_id,
                                           id: correcting_submission_id,
                                           correction: true),
                      text: 'View and correct errors'
        assert_select 'p.ccs-task-status-message',
                      text: 'There were errors with this submission. Please submit a corrected return.'
      end
    end

    it 'lists a task with a complete correction that is ready to submit' do
      correcting_task_id = '445d1dd2-d9b3-4432-8c17-b63e90e50bcd'
      correcting_submission_id = '67e7a34f-5d4c-4946-b045-da77f4b651db'
      assert_select "#task-#{correcting_task_id}" do
        assert_select '.govuk-tag__notice', text: 'Correction'
        assert_select 'a[href=?]',
                      task_submission_path(task_id: correcting_task_id, id: correcting_submission_id),
                      text: 'Review and submit'
        assert_select 'p.ccs-task-status-message',
                      text: 'This submission has been validated. Please review and submit to CCS.'
      end
    end
  end

  context 'when signed-in as a user with no tasks' do
    before do
      mock_empty_tasks_endpoint!
      mock_notifications_endpoint!
      stub_signed_in_user
      get tasks_path
    end

    it 'tells the user they have no tasks' do
      expect(response.body).to include 'All your tasks are complete.'
    end
  end

  context 'when viewing select tasks for bulk no business journey' do
    before do
      mock_tasks_bulk_new_endpoint!
      mock_user_with_multiple_suppliers_endpoint!
      mock_notifications_endpoint!
      stub_signed_in_user
      get bulk_new_tasks_path
    end

    it 'shows supplier names' do
      expect(response.body).to include 'Bandersnatch'
    end

    it 'shows unstarted tasks with framework name and due period' do
      expect(response.body).to include 'Multifunctional Devices, Managed Print and Content (RM3781) for November 2024'
    end
  end

  context 'when viewing task history' do
    before do
      mock_complete_tasks_endpoint!
      mock_user_endpoint!
      mock_notifications_endpoint!
      stub_signed_in_user
      get history_tasks_path
    end

    it 'shows the framework name of the completed task' do
      expect(response.body).to include 'Cheese Board 13'
    end

    it 'shows the month of period for the completed task' do
      expect(response.body).to include 'July 2018'
    end

    it 'shows the reported value for the completed task' do
      expect(response.body).to include '£12,345.67'
    end

    it 'shows the no business when appropriate for the completed task' do
      expect(response.body).to include 'No business'
    end

    it 'shows the completed date for the completed task' do
      expect(response.body).to include '14 February 2019 15:39 UTC'
    end

    it 'paginates the task list' do
      expect(response.body).to include 'Displaying <b>all 3</b> tasks'
    end
  end

  context 'when viewing a completed task that reported business' do
    before do
      mock_completed_task_with_invoice_details_endpoint!
      mock_user_endpoint!
      mock_notifications_endpoint!
      stub_signed_in_user

      get task_path(mock_task_id)
    end

    it 'shows details of the task and submission' do
      expect(response.body).to include 'Contracts'
      expect(response.body).to include 'Invoices'
      expect(response.body).to include '42'
      expect(response.body).to include '£12,345.67'
      expect(response.body).to include 'RM3786 MISO Data Template (August 2018).xls'
      expect(response.body).to include 'CINV-00123456'
      expect(response.body).to include 'Unpaid'
      expect(response.body).to include 'user@example.com'
    end

    it 'shows previous submission if there are any' do
      expect(response.body).to include 'Previous Submissions'
      expect(response.body).to include 'CINV-12345678'
      expect(response.body).to include '00054321'
    end
  end

  context 'when viewing a completed task that reported no business' do
    before do
      mock_completed_task_with_no_business_with_invoice_details_endpoint!
      mock_user_endpoint!
      mock_notifications_endpoint!
      stub_signed_in_user

      get task_path(mock_task_id)
    end

    it 'shows details of the task and no business submission' do
      expect(response.body).to include 'You reported no business'
    end
  end
end
