module ApiHelpers
  def api_url(path)
    "#{ENV['API_ROOT']}v1/#{path}"
  end

  def mock_task_id
    '2d98639e-5260-411f-a5ee-61847a2e067c'
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

  def mock_upload_task_submission_flow_endpoints!
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_create_submission_endpoint!
    mock_create_submission_file_endpoint!
    mock_create_submission_file_blob_endpoint!
    mock_submission_transitioning_to_in_review!
    mock_update_task_endpoint!
  end

  def mock_submission_pending_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_pending.json'))
  end

  def mock_submission_processing_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_processing.json'))
  end

  def mock_submission_validated_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_validated.json'))
  end

  def mock_submission_errored_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_errored.json'))
  end

  def mock_submission_completed_no_business_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_completed_no_business.json'))
  end

  def mock_submission_completed_report_mi_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_completed_report_mi.json'))
  end

  def mock_submission_completed_with_task_endpoint!
    stub_request(:get, api_url("submissions/#{mock_submission_id}?include=task"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_completed_with_task.json'))
  end

  def mock_submission_transitioning_to_in_review!
    stub_request(:get, api_url("submissions/#{mock_submission_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('submission_pending.json'))
      .then
      .to_return(headers: json_headers, body: json_fixture_file('submission_validated.json'))
  end

  def mock_complete_submission_endpoint!
    stub_request(:post, api_url("submissions/#{mock_submission_id}/complete"))
      .to_return(status: 204, body: '', headers: json_headers)
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
          status: 'completed',
          levy: nil,
        }
      }
    }

    stub_request(:post, api_url("tasks/#{mock_task_id}/no_business"))
      .to_return(status: 201, headers: json_headers, body: no_business_submission.to_json)
  end

  def mock_task_with_framework_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_framework.json'))
  end

  def mock_task_with_unsafe_short_name_framework_endpoint!
    json = JSON.parse(File.read(json_fixture_file('task_with_framework.json')))
    json['included'][0]['attributes']['short_name'] = 'CBOARD/5'
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=framework"))
      .to_return(headers: json_headers, body: json.to_json)
  end

  def mock_task_with_invalid_submission_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=latest_submission"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_invalid_submission.json'))
  end

  def mock_task_with_valid_submission_endpoint!
    stub_request(:get, api_url("tasks/#{mock_task_id}?include=latest_submission"))
      .to_return(headers: json_headers, body: json_fixture_file('task_with_valid_submission.json'))
  end

  def mock_tasks_endpoint!
    stub_request(:get, api_url('tasks'))
      .with(query: hash_including(filter: hash_including('auth_id')))
      .to_return(headers: json_headers, body: json_fixture_file('tasks_with_framework_and_latest_submission.json'))
  end

  def mock_empty_tasks_endpoint!
    stub_request(:get, api_url('tasks'))
      .with(query: hash_including(filter: hash_including('auth_id')))
      .to_return(headers: json_headers, body: '{}')
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
      data:  {
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
    submission_file_blob = {
    }

    stub_request(:post, api_url("files/#{mock_submission_file_id}/blobs"))
      .to_return(headers: json_headers, body: submission_file_blob.to_json)
  end

  def mock_update_task_endpoint!
    task_params = {
      data: {
        id: mock_task_id,
        type: 'tasks',
        attributes: {
          status: 'in_progress'
        }
      }
    }
    stub_request(:patch, api_url("tasks/#{mock_task_id}"))
      .with(body: task_params.to_json)
  end

  def mock_user_endpoint!
    stub_request(:get, api_url("users?filter[auth_id]=#{mock_auth_id}"))
      .to_return(headers: json_headers, body: json_fixture_file('user.json'))
  end

  def mock_user_with_multiple_suppliers_endpoint!
    stub_request(:get, api_url("users?filter[auth_id]=#{mock_auth_id}"))
      .to_return(
        headers: json_headers,
        body: json_fixture_file('user_with_multiple_suppliers.json')
      )
  end

  private

  def json_headers
    {
      'Content-Type': 'application/vnd.api+json; charset=utf-8',
      'X-Auth-Id': '123456'
    }
  end

  def json_fixture_file(filename)
    Rails.root.join('spec', 'fixtures', 'mocks', filename)
  end
end
