require 'rails_helper'

RSpec.feature 'User reviews completed spreadsheet' do
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

      submission_with_files_and_entries = {
        data: {
          id: '9a5ef62c-0781-4f80-8850-5793652b6b40',
          type: 'submissions',
          attributes: {
            framework_id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            supplier_id: 'cd40ead8-67b5-4918-abf0-ab8937cd04ff'
          },
          relationships: {
            entries: {
              data: [
                {
                  type: 'submission_entries',
                  id: 'f87717d4-874a-43d9-b99f-c8cf2897b526'
                },
                {
                  type: 'submission_entries',
                  id: '1eb3b8ee-0ac6-4b8f-86a5-6886b33c63ff'
                },
                {
                  type: 'submission_entries',
                  id: '32423310-e3b6-4e2f-b022-a4854d8085ab'
                }
              ]
            },
            files: {
              data: [
                {
                  type: 'submission_files',
                  id: '41bea03d-fc99-45fb-9efc-2787530409f8'
                }
              ]
            }
          }
        },
        included: [
          {
            id: 'f87717d4-874a-43d9-b99f-c8cf2897b526',
            type: 'submission_entries',
            attributes: {
              source: { row: 42, sheet: 'InvoicesRaised' },
              data: { test: 'test' },
              status: 'validated'
            }
          },
          {
            id: '32423310-e3b6-4e2f-b022-a4854d8085ab',
            type: 'submission_entries',
            attributes: {
              source: { row: 40, sheet: 'Invoices Raised' },
              data: { test: 'test' },
              status: 'validated'
            }
          },
          {
            id: '1eb3b8ee-0ac6-4b8f-86a5-6886b33c63ff',
            type: 'submission_entries',
            attributes: {
              source: { row: 1, sheet: ' Orders  Received ' },
              data: { test: 'test' },
              status: 'validated'
            }
          },
          {
            id: '41bea03d-fc99-45fb-9efc-2787530409f8',
            type: 'submission_files',
            attributes: {
              submission_id: '9a5ef62c-0781-4f80-8850-5793652b6b40',
              rows: 3
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

      stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40/files')
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: submission_file.to_json
        )

      stub_request(:get, 'https://ccs.api/v1/submissions/9a5ef62c-0781-4f80-8850-5793652b6b40?include=files,entries')
        .to_return(
          headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
          body: submission_with_files_and_entries.to_json
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
    end

    scenario 'successfully review and complete the submission process' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Submit management information'

      expect(page).to have_content('Upload management information data for CBOARD5')

      attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
      click_button 'Upload'

      expect(page).to have_content('Review your information')

      within '#invoices' do
        expect(page).to have_content('2')
      end

      within '#orders' do
        expect(page).to have_content('1')
      end
    end

    scenario 'and cancel/go back to re upload the spreadsheet' do
      mock_sso_with(email: 'email@example.com')

      visit '/tasks'
      click_on 'Submit management information'

      expect(page).to have_content('Upload management information data for CBOARD5')

      attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
      click_button 'Upload'

      expect(page).to have_content('Review your information')
      click_on 'submit another file'

      expect(page).to have_content('Upload and submit data')
    end
  end
end
