require 'rails_helper'

RSpec.feature 'Bulk reporting no business' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_notifications_endpoint!
    mock_tasks_bulk_new_endpoint!
    mock_tasks_bulk_confirm_endpoint!
    mock_task_bulk_no_business_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_user_with_multiple_suppliers_endpoint!
  end

  scenario 'user completes multiple tasks reporting "no business"' do
    mock_user_endpoint!

    visit '/'
    click_button 'sign-in'

    visit '/submissions/bulk_new'

    expect(page).to have_content 'Multifunctional Devices, Managed Print and Content (RM3781) for November 2024'
    expect(page).to have_content 'Multifunctional Devices, Managed Print and Content (RM3781) for October 2024'
    expect(page).to have_content 'Multifunctional Devices, Managed Print and Content (RM3781) for September 2024'

    check('task_id_af669abb-4674-43ba-88a6-a938c11e86a5')
    check('task_id_aae5bfb4-696f-4c4e-bfd9-08e18e3e65aa')

    click_on 'Report no business'

    expect(page).to_not have_content 'This is a correction'
    expect(page).to have_content 'you are confirming that you have no transactions to report for these tasks.'
    expect(page).to have_content 'October 2024'
    expect(page).to_not have_content 'September 2024'

    click_on 'Confirm no business'

    expect(page).to have_content 'Tasks complete'
    expect(page).to have_content 'email report-mi@crowncommercial.gov.uk for help'
  end
end
