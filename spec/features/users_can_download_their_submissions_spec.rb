require 'rails_helper'

RSpec.feature 'downloading a submission' do
  scenario 'user sees a download link' do
    mock_sso_with(email: 'email@example.com')
    mock_user_endpoint!
    mock_incomplete_tasks_endpoint!

    mock_completed_task_with_invoice_details_endpoint!

    visit '/'
    click_button 'sign-in'

    visit "/tasks/#{mock_task_id}"

    expect(page).to have_link(
      'RM3786 MISO Data Template (August 2018).xls',
      href: download_task_submission_path(mock_task_id, mock_submission_id)
    )
  end
end
