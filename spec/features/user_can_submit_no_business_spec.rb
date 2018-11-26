require 'rails_helper'

RSpec.feature 'Submitting no business' do
  scenario 'user completes a task, reporting "no business"' do
    travel_to Time.zone.local(2018, 7, 2)

    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_no_business_endpoint!
    mock_submission_completed_no_business_endpoint!
    mock_user_endpoint!

    visit '/'
    click_link 'start-now'

    visit '/tasks'

    expect(page).to have_content 'CBOARD5'

    click_on 'Report no business'

    expect(page).to have_content 'Report no business'

    click_on 'Confirm'

    expect(page).to have_content 'Thank you for reporting no business for'
  end
end
