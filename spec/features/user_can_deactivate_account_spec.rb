require 'rails_helper'

RSpec.describe 'deactivating an account' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_notifications_endpoint!
    mock_user_who_can_deactivate_endpoint!
    mock_suppliers_endpoint!
    mock_email_verification_pending_endpoint!
    mock_user_auth_logs_endpoint!
    mock_deactivate_user_endpoint!
  end

  scenario 'an eligible user deactivates their account' do
    visit '/'
    click_button 'sign-in'
    visit user_detail_path

    click_link 'Deactivate account'

    expect(page).to have_content 'Deactivate my account'
    expect(page).to have_link('Back', href: user_detail_path)
    expect(page).to have_link('Cancel', href: user_detail_path)

    click_button 'Continue to deactivate my account'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content 'Your account has been deactivated.'
  end
end
