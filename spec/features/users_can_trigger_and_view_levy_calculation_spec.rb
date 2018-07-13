require 'rails_helper'

RSpec.feature 'User triggers and views levy calculation' do
  feature 'Signed-in user can review an uploaded completed spreadsheet' do
    before(:each) do
      tasks = {
        data: [
          id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          type: 'tasks',
          attributes: {
            description: 'test task',
            due_on: '2030-01-01',
            framework_id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            supplier_id: 'cd40ead8-67b5-4918-abf0-ab8937cd04ff'
          }
        ]
      }

      task_with_framework = {
        data: {
          id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          type: 'tasks',
          attributes: {
            description: 'test task',
            due_on: '2030-01-01',
            framework_id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            supplier_id: 'cd40ead8-67b5-4918-abf0-ab8937cd04ff'
          },
          relationships: {
            framework: {
              data: {
                type: 'frameworks',
                id: 'f87717d4-874a-43d9-b99f-c8cf2897b526'
              }
            }
          }
        },
        included: [
          {
            id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            type: 'frameworks',
            attributes: {
              short_name: 'CBOARD5',
              name: 'Cheese Board 5'
            }
          }
        ]
      }

      task_submission = {
        data: {
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40',
          type: 'submissions',
          attributes: {
            task_id: '2d98639e-5260-411f-a5ee-61847a2e067c'
          }
        }
      }

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

      stub_request(:get, 'https://ccs.api/v1/tasks')
        .with(query: hash_including({}))
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: tasks.to_json
        )

      stub_request(:get, 'https://ccs.api/v1/tasks/2d98639e-5260-411f-a5ee-61847a2e067c?include=framework')
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: task_with_framework.to_json
        )

      stub_request(:post, 'https://ccs.api/v1/submissions')
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: task_submission.to_json
        )

      stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40/files')
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: submission_file.to_json
        )

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

      stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40/calculate')
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          status: 200
        )
    end

    scenario 'successfully triggers levy calculation' do
      mock_submission_without_levy

      login_and_upload_file

      expect(page).to have_content('Review your information')

      click_link 'Continue'
      expect(page).to have_content('processing...')
    end

    scenario 'successfully views levy calculation' do
      mock_submission_with_levy_completed

      login_and_upload_file

      expect(page).to have_content('Your Levy Calculation is: £ 4500')
    end
  end

  def login_and_upload_file
    mock_sso_with(email: 'email@example.com')

    visit '/'
    click_on 'Sign in'

    visit '/tasks'
    click_on 'Upload submission'

    expect(page).to have_content('Upload submission for CBOARD5')

    attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
    click_button 'Upload'
  end

  def mock_submission_without_levy
    stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=files,entries')
      .to_return(
        headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
        body: Rails.root.join('spec', 'fixtures', 'submission.json')
      )
  end

  def mock_submission_with_levy_completed
    stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=files,entries')
      .to_return(
        headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
        body: Rails.root.join('spec', 'fixtures', 'submission_with_levy.json')
      )
  end
end
