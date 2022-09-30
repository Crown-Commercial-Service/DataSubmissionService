require 'rails_helper'

RSpec.feature 'downloading a template' do
  scenario 'user sees a template link' do
    mock_sso_with(email: 'email@example.com')
    mock_user_with_multiple_suppliers_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_agreements_with_framework_and_supplier_endpoint!

    visit '/'
    click_button 'sign-in'

    visit '/agreements'

    expect(page).to have_link(
      'Download template (excel document)',
      href: template_path(id: mock_framework_id, agreements_page: true)
    )
  end
end
