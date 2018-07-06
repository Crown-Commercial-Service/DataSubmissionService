require 'rails_helper'

RSpec.feature 'User uploads completed spreadsheet' do
  describe 'Signed-in user can upload a completed spreadsheet' do
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

      submission_with_entries = {
        data: {
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40',
          type: 'submissions',
          attributes: {
            framework_id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            supplier_id: 'cd40ead8-67b5-4918-abf0-ab8937cd04ff'
          },
          relationships: {
            entries: {
              data: {
                type: 'submission_entries',
                id: 'f87717d4-874a-43d9-b99f-c8cf2897b526'
              }
            }
          }
        },
        included: [
          {
            id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            type: 'submission_entries',
            attributes: {
              source: { row: 42, sheet: 'InvoicesReceived' },
              data: { test: 'test' },
              status: 'pending'
            }
          }
        ]
      }

      stub_request(:get, 'https://ccs.api/v1/tasks')
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

      stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=entries')
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: submission_with_entries.to_json
        )
    end

    scenario 'successfully, if the file has an xlsx or xlx content_type' do
      mock_sso_with(email: 'email@example.com')

      task = {
        data: {
          id: '2d98639e-5260-411f-a5ee-61847a2e067c',
          type: 'tasks',
          attributes: {
            status: 'in_progress',
            description: 'test task',
            due_on: '2030-01-01',
            framework_id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            supplier_id: 'cd40ead8-67b5-4918-abf0-ab8937cd04ff'
          }
        }
      }

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
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: task.to_json
        )

      visit '/tasks'
      click_on 'Submit management information'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
        click_button 'Upload'
      end.to change(ActiveStorage::Blob, :count).by(1)

      blob = ActiveStorage::Blob.last

      expect(page).to have_content('upload successful')
      expect(page).to have_content(blob.filename)
    end

    scenario 'throws an error if the file does not have xlsx or xlx content_type' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Submit management information'

      expect do
        attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.pdf')
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content('File content_type must be an xlsx or xlx')
    end

    scenario 'throws an error if no file was selected' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Submit management information'

      expect do
        click_button 'Upload'
      end.not_to change(ActiveStorage::Blob, :count)

      expect(page).to have_content('Please select a file')
    end
  end
end
