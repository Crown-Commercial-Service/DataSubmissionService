# rubocop:disable Metrics/ModuleLength just mocks; don't care
module ApiHelpers
  def api_url(path)
    "#{ENV['API_ROOT']}v1/#{path}"
  end

  def mock_task_id
    '2d98639e-5260-411f-a5ee-61847a2e067c'
  end

  def mock_correcting_task_id
    'b847e0f7-027e-4b95-afa2-3490b8d05a1d'
  end

  def mock_submission_id
    '9a5ef62c-0781-4f80-8850-5793652b6b40'
  end

  def mock_submission_file_id
    '8d0e4289-5fde-4faa-b78e-922846d8460a'
  end

  def mock_auth_id
    'auth0|123456'
  end

  def mock_user_id
    'efa8ebb8-de51-4718-b085-a583f8d41e3e'
  end

  def mock_framework_id
    '7a50a178-3fb8-4c0a-9f2c-8841812448d1'
  end

  def mock_release_note_id
    'fbf94677-8f2c-44b9-8546-e8e8dcc576de'
  end

  def hash_including_correction
    {
      body: {
        "data": hash_including('attributes' => hash_including('correction' => 'true'))
      }
    }
  end

  def mock_upload_task_submission_flow_endpoints!
    mock_unstarted_tasks_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_task_with_framework_and_active_submission_endpoint!
    mock_create_submission_endpoint!
    mock_create_submission_file_endpoint!
    mock_create_submission_file_blob_endpoint!
    mock_submission_transitioning_to_in_review!
    mock_update_task_endpoint!
  end

  def mock_submission_pending_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_pending.json'))
  end

  def mock_submission_processing_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_processing.json'))
  end

  def mock_submission_validated_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_validated.json'))
  end

  def mock_submission_errored_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_errored.json'))
  end

  def mock_submission_management_charge_calculation_failed_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_management_charge_calculation_failed.json'))
  end

  def mock_submission_completed_no_business_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_completed_no_business.json'))
  end

  def mock_submission_completed_report_mi_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_completed_report_mi.json'))
  end

  def mock_submission_completed_with_task_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=task"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_completed_with_task.json'))
  end

  def mock_submission_validated_with_task_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=task"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_validated_with_task.json'))
  end

  def mock_submission_transitioning_to_in_review!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=files"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_pending.json'))
      .then
      .to_return(headers: json_headers, body: json_fixture_file('submission_validated.json'))
  end

  def mock_complete_submission_endpoint!
    stub_request(:post, api_url("submissions/#{mock_submission_id}/complete"))
      .to_return(status: 204, body: '', headers: json_headers)
  end

  def mock_submission_with_file_endpoint!
    stub_request(
      :get,
      api_url("submissions/#{mock_submission_id}")
    ).to_return(headers: json_headers, body: json_fixture_file('submission_with_file.json'))
  end

  def mock_no_business_endpoint!
    no_business_submission = {
      data: {
        id: mock_submission_id,
        type: 'submissions',
        attributes: {
          task_id: mock_task_id,
          framework_id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
          supplier_id: 'cd40ead8-67b5-4918-abf0-ab8937cd04ff',
          status: 'completed'
        }
      }
    }

    stub_request(:post, api_url("tasks/#{mock_task_id}/no_business"))
      .with(body: {}.to_json)
      .to_return(status: 201, headers: json_headers, body: no_business_submission.to_json)
  end

  def mock_no_business_correction_endpoint!
    no_business_submission = {
      data: {
        id: mock_submission_id,
        type: 'submissions',
        attributes: {
          task_id: mock_task_id,
          framework_id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
          supplier_id: 'cd40ead8-67b5-4918-abf0-ab8937cd04ff',
          status: 'completed'
        }
      }
    }

    stub_request(:post, api_url("tasks/#{mock_task_id}/no_business"))
      .with(body: { correction: 'true' }.to_json)
      .to_return(status: 201, headers: json_headers, body: no_business_submission.to_json)
  end

  def mock_agreements_with_framework_and_supplier_endpoint!
    stub_request(:get, api_url('agreements?filter%5Bactive%5D&include=framework,supplier'))
      .to_return(headers: json_headers, body: json_fixture_file('agreements_with_framework_and_supplier.json'))
  end

  def mock_framework_and_file_endpoint!
    stub_request(:get, api_url("frameworks/#{mock_framework_id}?include_file=true"))
      .to_return(headers: json_headers, body: json_fixture_file('framework.json'))
  end

  def mock_framework_and_file_with_unsafe_short_name_endpoint!
    json = JSON.parse(File.read(json_fixture_file('framework.json')))
    json['data']['attributes']['short_name'] = 'cboard/12'
    stub_request(:get, api_url("frameworks/#{mock_framework_id}?include_file=true"))
      .to_return(headers: json_headers, body: json.to_json)
  end

  def mock_frameworks_endpoint!
    stub_request(:get, api_url('frameworks'))
      .to_return(headers: json_headers, body: json_fixture_file('frameworks.json'))
  end

  def mock_task_with_framework_endpoint!(include_file: false)
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework#{'&include_file=true' if include_file}"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_framework.json'))
  end

  def mock_task_with_framework_and_active_submission_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework,active_submission"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_framework_and_no_business_submission.json'))
  end

  def mock_task_with_framework_and_file_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework&include_file=true"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_framework_and_file.json'))
  end

  def mock_correcting_task_with_framework_endpoint!
    stub_request(:get, api_url("tasks/#{mock_correcting_task_id}?include=framework"))
      .to_return(headers: json_headers, body: json_fixture_file('correcting_task_with_framework.json'))
  end

  def mock_correcting_task_with_framework_and_active_submission_endpoint!
    stub_request(:get, api_url("tasks/#{mock_correcting_task_id}?include=framework,active_submission"))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('correcting_task_with_framework_and_active_submission.json')
      )
  end

  def mock_correcting_task_with_framework_invoice_details_and_active_submission_endpoint!
    stub_request(:get, api_url("tasks/#{mock_correcting_task_id}?include=framework,past_submissions,active_submission.invoice_details,active_submission.files"))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('correcting_task_with_framework_and_active_submission.json')
      )
  end

  def mock_task_with_unsafe_short_name_framework_endpoint!(include_file: false)
    json = JSON.parse(File.read(json_fixture_file('task_with_framework.json')))
    json['included'][0]['attributes']['short_name'] = 'CBOARD/5'
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework#{'&include_file=true' if include_file}"))
      .to_return(headers: json_headers, body: json.to_json)
  end

  def mock_task_with_invalid_submission_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=active_submission"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_invalid_submission.json'))
  end

  def mock_task_with_submission_that_failed_ingest_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=active_submission"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_submission_that_failed_ingest.json'))
  end

  def mock_task_with_submission_that_failed_management_charge_calculation_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=active_submission"))
      .to_return(headers: json_headers,
                 body: json_fixture_file('task_with_submission_that_failed_management_charge_calculation.json'))
  end

  def mock_task_with_valid_submission_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=active_submission"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_valid_submission.json'))
  end

  def mock_incomplete_tasks_endpoint!
    stub_request(:get, api_url('tasks'))
      .with(query: hash_including(filter: hash_including('status' => ['unstarted', 'in_progress', 'correcting'])))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('incomplete_tasks_with_framework_and_active_submission.json')
      )
  end

  def mock_unstarted_task_endpoint!
    stub_request(:get, api_url('tasks?filter%5Bstatus%5D=unstarted'))
      .to_return(headers: json_headers, body: json_fixture_file('unstarted_task.json'))
  end

  def mock_unstarted_tasks_endpoint!
    stub_request(:get, api_url('tasks?filter%5Bstatus%5D=unstarted'))
      .to_return(headers: json_headers, body: json_fixture_file('unstarted_tasks.json'))
  end

  def mock_complete_tasks_endpoint!
    stub_request(:get, api_url('tasks'))
      .with(query: hash_including(filter: hash_including('status' => 'completed')))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('complete_tasks_with_framework_and_active_submission.json')
      )
  end

  def mock_filter_complete_tasks_endpoint!
    fields = 'fields%5Bsubmissions%5D=status,framework_id,submitted_at,invoice_total_value,report_no_business?'
    framework = 'filter%5Bframework_id%5D%5B0%5D=485c9fdd-cfc9-4b3c-9a69-a8195f9c13bc'
    status = 'filter%5Bstatus%5D=completed'
    stub_request(:get, api_url("tasks?#{fields}&#{framework}&#{status}&include=framework,active_submission"))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('complete_tasks_with_framework_and_active_submission_filtered.json')
      )
  end

  def mock_empty_tasks_endpoint!
    stub_request(:get, api_url('tasks'))
      .with(query: hash_including(filter: hash_including('status')))
      .to_return(headers: json_headers, body: '{}')
  end

  def mock_completed_task_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework,active_submission.files"))
      .to_return(headers: json_headers, body: json_fixture_file('completed_task.json'))
  end

  def mock_completed_task_with_invoice_details_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework,past_submissions,active_submission.invoice_details,active_submission.files"))
      .to_return(headers: json_headers, body: json_fixture_file('completed_task.json'))
  end

  def mock_task_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('completed_task.json'))
  end

  def mock_correcting_task_endpoint!
    stub_request(:get, api_url("tasks/#{mock_correcting_task_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('correcting_task.json'))
  end

  def mock_correction_cancellation_endpoint!
    stub_request(:patch, api_url("tasks/#{mock_correcting_task_id}/cancel_correction"))
  end

  def mock_completed_task_with_no_business_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework,active_submission.files"))
      .to_return(headers: json_headers, body: json_fixture_file('completed_task_with_no_business.json'))
  end

  def mock_completed_task_with_no_business_with_invoice_details_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework,past_submissions,active_submission.invoice_details,active_submission.files"))
      .to_return(headers: json_headers, body: json_fixture_file('completed_task_with_no_business.json'))
  end

  def mock_create_submission_endpoint!
    task_submission = {
      data: {
        id: mock_submission_id,
        type: 'submissions',
        attributes: {
          task_id: mock_task_id,
          status: 'pending'
        }
      }
    }
    stub_request(:post, api_url('submissions'))
      .to_return(headers: json_headers, body: task_submission.to_json)
  end

  def mock_create_submission_file_endpoint!
    submission_file = {
      data: {
        id: mock_submission_file_id,
        type: 'submission_files',
        attributes: {
          submission_id: mock_submission_id
        }
      }
    }

    stub_request(:post, api_url("submissions/#{mock_submission_id}/files"))
      .to_return(headers: json_headers, body: submission_file.to_json)
  end

  def mock_create_submission_file_blob_endpoint!
    submission_file_blob = {}

    stub_request(:post, api_url("files/#{mock_submission_file_id}/blobs"))
      .to_return(headers: json_headers, body: submission_file_blob.to_json)
  end

  def mock_update_task_endpoint!(status: 'in_progress')
    task_params = {
      data: {
        id: mock_task_id,
        type: 'tasks',
        attributes: {
          status: status
        }
      }
    }
    stub_request(:patch, api_url("tasks/#{mock_task_id}"))
      .with(body: task_params.to_json)
  end

  def mock_user_endpoint!
    stub_request(:get, api_url("users?filter[auth_id]=#{JWT.encode(mock_auth_id, 'test')}"))
      .to_return(headers: json_headers, body: json_fixture_file('user.json'))
  end

  def mock_user_with_multiple_suppliers_endpoint!
    stub_request(:get, api_url("users?filter[auth_id]=#{JWT.encode(mock_auth_id, 'test')}"))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('user_with_multiple_suppliers.json')
      )
  end

  def mock_customer_effort_score_endpoint!
    feedback_params = {
      data: {
        type: 'customer_effort_scores',
        attributes: {
          rating: nil,
          comments: nil,
          user_id: mock_user_id
        }
      }
    }
    stub_request(:post, api_url('customer_effort_scores'))
      .with(body: feedback_params.to_json)
  end

  def mock_customers_endpoint!
    stub_request(:get, api_url('customers?filter%5Bsearch%5D&page%5Bpage%5D'))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('customers.json')
      )
  end

  def mock_notifications_endpoint!
    stub_request(:get, api_url('notifications'))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('notification.json')
      )
  end

  def mock_release_notes_endpoint!
    stub_request(:get, api_url('release_notes'))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('release_notes.json')
      )
  end

  def mock_release_note_endpoint!
    stub_request(:get, api_url("release_notes/#{mock_release_note_id}"))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('release_note.json')
      )
  end

  def mock_tasks_bulk_new_endpoint!
    stub_request(:get, api_url('tasks/index_by_supplier?status=unstarted'))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('tasks_index_by_supplier.json')
      )
  end

  def mock_tasks_bulk_confirm_endpoint!
    stub_request(:get, api_url('tasks/index_by_supplier?status=unstarted&task_ids%5B%5D=aae5bfb4-696f-4c4e-bfd9-08e18e3e65aa&task_ids%5B%5D=af669abb-4674-43ba-88a6-a938c11e86a5'))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('tasks_index_by_supplier_two_selected.json')
      )
  end

  def mock_task_bulk_no_business_endpoint!
    stub_request(:post, 'https://ccs.api/v1/tasks/bulk_no_business')
      .with(
        body: '{"task_ids":["af669abb-4674-43ba-88a6-a938c11e86a5","aae5bfb4-696f-4c4e-bfd9-08e18e3e65aa"]}'
      ).to_return(
        headers: json_headers,
        body: json_fixture_file('tasks_bulk_no_business.json')
      )
  end

  private

  def json_headers
    {
      'Content-Type': 'application/vnd.api+json; charset=utf-8',
      'X-Auth-Id': JWT.encode(mock_auth_id, 'test')
    }
  end

  def json_fixture_file(filename)
    Rails.root.join('spec', 'fixtures', 'mocks', filename)
  end
end
# rubocop:enable Metrics/ModuleLength
