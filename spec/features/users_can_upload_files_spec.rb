require 'rails_helper'

RSpec.feature 'User uploads a file' do
  scenario 'Signed-in user can upload a file' do
    mock_sso_with(email: 'email@example.com')

    visit '/tasks'
    click_on 'Sign in'

    expect do
      attach_file 'upload', Rails.root.join('spec', 'fixtures', 'uploads', 'empty.xlsx')
      click_button 'Upload file'
    end.to change(ActiveStorage::Blob, :count).by(1)

    blob = ActiveStorage::Blob.last

    expect(current_path).to eq(tasks_path)
    expect(page).to have_content('upload successful')
    expect(page).to have_content(blob.filename)
  end
end
