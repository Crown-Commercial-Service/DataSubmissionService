module ApiHelpers
  def mock_upload_task_submission_flow_endpoints!
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_create_submission_endpoint!
    mock_submission_file_endpoint!
  end

  def mock_pending_submission_endpoint!
    stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=files,entries')
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: Rails.root.join('spec', 'fixtures', 'mocks', 'submission_pending.json'))
  end

  def mock_submission_with_entries_pending_endpoint!
    stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=files,entries')
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: Rails.root.join('spec', 'fixtures', 'mocks', 'submission_with_entries_pending.json'))
  end

  def mock_submission_with_entries_validated_endpoint!
    stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=files,entries')
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: Rails.root.join('spec', 'fixtures', 'mocks', 'submission_with_entries_validated.json'))
  end

  def mock_submission_with_levy_completed_endpoint!
    stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=files,entries')
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: Rails.root.join('spec', 'fixtures', 'mocks', 'submission_with_levy_completed.json'))
  end

  def mock_task_with_framework_endpoint!
    stub_request(:get, 'https://ccs.api/v1/tasks/2d98639e-5260-411f-a5ee-61847a2e067c?include=framework')
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: Rails.root.join('spec', 'fixtures', 'mocks', 'task_with_framework.json'))
  end

  def mock_tasks_endpoint!
    tasks = {
      data: [
        {
          id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          type: 'tasks',
          attributes: {
            status: 'ready',
            description: 'First task',
            due_on: '2030-01-01'
          }
        }
      ]
    }
    stub_request(:get, 'https://ccs.api/v1/tasks')
      .with(query: hash_including({}))
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: tasks.to_json)
  end

  def mock_create_submission_endpoint!
    task_submission = {
      data: {
        id: '9a5ef62c-0781-4f80-8850-5793652b6b40',
        type: 'submissions',
        attributes: {
          task_id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          status: 'pending'
        }
      }
    }
    stub_request(:post, 'https://ccs.api/v1/submissions')
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: task_submission.to_json)
  end

  def mock_submission_file_endpoint!
    submission_file = {
      data: {
        id: '41bea03d-fc99-45fb-9efc-2787530409f8',
        type: 'submission_files',
        attributes: {
          submission_id: '9a5ef62c-0781-4f80-8850-5793652b6b40',
          rows: 3
        }
      }
    }
    stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40/files')
      .to_return(headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
                 body: submission_file.to_json)
  end

  def mock_update_task_endpoint!
    task_params = {
      data: {
        id: '2d98639e-5260-411f-a5ee-61847a2e067c',
        type: 'tasks',
        attributes: {
          status: 'in_progress'
        }
      }
    }
    stub_request(:patch, 'https://ccs.api/v1/tasks/2d98639e-5260-411f-a5ee-61847a2e067c')
      .with(body: task_params.to_json)
  end

  def mock_levy_calculate_endpoint!
    stub_request(:post, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40/calculate')
      .to_return(status: 200)
  end

  def mock_task_complete_endpoint!
    stub_request(:post, 'https://ccs.api/v1/tasks/2d98639e-5260-411f-a5ee-61847a2e067c/complete')
      .to_return(status: 200)
  end

  def mock_update_submission_endpoint!
    stub_request(:patch, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40')
      .to_return(status: 200)
  end
end
