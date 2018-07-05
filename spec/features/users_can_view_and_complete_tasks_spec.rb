require 'rails_helper'

RSpec.feature 'Managing tasks' do
  scenario 'viewing a list of tasks' do
    mock_sso_with(email: 'email@example.com')

    mock_api_response = {
      data: [
        {
          id: 'c40e8593-7a2d-4aea-87a9-ca7ddb252974',
          type: 'tasks',
          attributes: {
            status: 'started',
            description: 'First task',
            due_on: '2025-01-01'
          }
        },
        {
          id: '3712b463-3879-4a0f-83c1-a0f514b6fb27',
          type: 'tasks',
          attributes: {
            status: 'ready',
            description: 'Second task',
            due_on: '2025-02-01'
          }
        }
      ]
    }

    stub_request(:get, 'https://ccs.api/v1/tasks')
      .to_return(
        headers: { 'Content-Type': 'application/vnd.api+json; charset=utf-8' },
        body: mock_api_response.to_json
      )

    visit '/'
    click_on 'Sign in'

    Timecop.freeze(Time.zone.local(2018, 7, 2)) do
      visit '/tasks'
    end

    expect(page).to have_text 'Tasks for July'
    expect(page).to have_text 'First task'
    expect(page).to have_text 'Second task'
  end
end
