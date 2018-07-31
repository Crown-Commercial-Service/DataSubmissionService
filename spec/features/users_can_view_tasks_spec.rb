require 'rails_helper'

RSpec.feature 'Managing tasks' do
  scenario 'viewing a list of tasks' do
    mock_sso_with(email: 'email@example.com')
    mock_tasks_endpoint!

    visit '/'
    click_link 'sign-in'

    travel_to(Time.zone.local(2018, 7, 2)) do
      visit '/tasks'
    end

    expect(page).to have_text 'Tasks'
    expect(page).to have_text 'Unstarted task'
  end
end
