require 'rails_helper'

RSpec.feature 'User uploads a file' do
  scenario 'Signed-in user can upload a file' do
    mock_sso_with(email: 'email@example.com')

    visit '/tasks'
    click_on 'Sign in'

    attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
    click_button 'Upload file'

    # TODO: Add expectations!
  end
end
