require 'rails_helper'

RSpec.feature 'User can view release notes' do
  scenario 'User visits the release notes page' do
    mock_sso_with(email: 'email@example.com')
    mock_unstarted_tasks_endpoint!
    mock_incomplete_tasks_endpoint!
    mock_user_endpoint!
    mock_notifications_endpoint!
    mock_release_notes_endpoint!
    mock_release_note_endpoint!

    visit '/'
    click_button 'sign-in'

    visit '/release_notes'

    expect(page).to have_content 'This one contains markdown'
    expect(page).to have_content 'Franz Kafka is the original sad boy - discuss'
    expect(page).to have_content 'Testy McTestface the ninth'
  end
end
