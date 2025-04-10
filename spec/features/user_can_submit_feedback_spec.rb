require 'rails_helper'

RSpec.feature 'Submitting customer effort score' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_notifications_endpoint!
    mock_unstarted_tasks_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_task_with_framework_and_active_submission_endpoint!
    mock_no_business_endpoint!
    mock_submission_completed_no_business_endpoint!
  end

  scenario 'user submits feedback after completing a task' do
    mock_user_endpoint!

    allow_any_instance_of(API::CustomerEffortScore).to receive(:save).and_return(false)
    allow_any_instance_of(API::CustomerEffortScore).to receive_message_chain(:errors)
      .and_return(rating: ['Invalid rating'])

    visit '/'
    click_button 'sign-in'
    visit '/tasks'
    click_on 'Report no business'
    click_on 'Confirm no business'

    expect(page).to have_content 'Overall how easy was it to use this service today?'
    expect(page).to have_content 'How could we improve this service?'

    click_on 'Send feedback'

    expect(page).to have_content 'Feedback not submitted, please see below.'
  end
end
