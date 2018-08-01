require 'rails_helper'

RSpec.feature 'Viewing the homepage' do
  context 'without signing in' do
    scenario 'can see the introductory text' do
      visit '/'

      expect(page).to have_content 'Before you start'
    end
  end

  context 'whilst signed in' do
    scenario 'can see instructions for viewing tasks' do
      mock_sso_with(email: 'email@example.com')
      mock_tasks_endpoint!

      visit '/'
      click_link 'sign-in'
      visit '/'

      expect(page).to have_link 'View your tasks'
      expect(page).to have_link 'Go to tasks'
    end
  end
end
