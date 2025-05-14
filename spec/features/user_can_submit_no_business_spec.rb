require 'rails_helper'

RSpec.feature 'Submitting no business' do
  before do
    travel_to Time.zone.local(2018, 7, 2)

    mock_sso_with(email: 'email@example.com')
    mock_notifications_endpoint!
    mock_unstarted_tasks_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_task_with_framework_and_active_submission_endpoint!
    mock_no_business_endpoint!
    mock_submission_completed_no_business_endpoint!
  end

  scenario 'user completes a task, reporting "no business" when linked to one supplier' do
    mock_user_endpoint!

    visit '/'
    click_button 'sign-in'

    visit '/tasks'

    expect(page).to have_content 'CBOARD5'
    expect(page).to_not have_content 'Bobs Cheese Shop'

    click_on 'Report no business'

    expect(page).to_not have_content 'This is a correction'
    expect(page).to have_content 'Report no business'
    expect(page).to have_content 'CBOARD5 Cheese Board 5'
    expect(page).to_not have_content 'Bobs Cheese Shop'

    click_on 'Confirm no business'

    expect(page).to_not have_content 'This is a correction'
    expect(page).to have_content 'Thank you for reporting no business for'
    expect(page).to_not have_content 'Bobs Cheese Shop'
  end

  scenario 'user can see the current supplier name on the complete no business
    views when linked to multiple suppliers' do
    mock_user_with_multiple_suppliers_endpoint!

    visit '/'
    click_button 'sign-in'

    visit '/tasks'

    expect(page).to have_content 'CBOARD5'
    expect(page).to have_content 'Bobs Cheese Shop'

    click_on 'Report no business'

    expect(page).to have_content 'Report no business'
    expect(page).to have_content 'Bobs Cheese Shop'

    click_on 'Confirm'

    expect(page).to have_content 'Thank you for reporting no business for'
    expect(page).to have_content 'Bobs Cheese Shop'
  end
end
