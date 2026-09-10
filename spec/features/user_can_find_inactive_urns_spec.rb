require 'rails_helper'

RSpec.feature 'Finding inactive URNs' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_unstarted_tasks_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_user_endpoint!
    mock_notifications_endpoint!
    mock_customers_endpoint!
    mock_inactive_customers_endpoint!
  end

  scenario 'user looks for inactive URN list' do
    visit '/'
    click_button 'sign-in'
    visit '/urns'
    click_link 'view our log of recent changes'

    expect(page).to have_content 'Inactive URN list'
    expect(page).to have_content 'You can search for inactive URNs below, or access our published downloadable list'
    expect(page).to have_content 'Inactive customer Inactive Date Replacement customer Replacement postcode'
    expect(page).to have_content 'Ministry for Silly Walks 56338561 2023-01-01 Ministry for Outrageous Hats 56338562'
  end

  scenario 'user searches recent URN changes' do
    mock_inactive_customers_search_endpoint!
    visit '/'
    click_button 'sign-in'
    visit inactive_urns_path
    fill_in 'search', with: 'Silly'
    click_button 'Search'

    expect(page).to have_content 'Inactive URN list'
    expect(page).to have_content 'Ministry for Silly Hats 56338561 2023-01-01 Ministry for Even Sillier Hats 56338562'
  end
end
