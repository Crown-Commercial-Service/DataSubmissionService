require 'rails_helper'

RSpec.describe 'the home page' do
  it 'shows introductory text for non-signed in users' do
    get root_path

    expect(response.body).to include 'Before you sign in'
  end

  it 'links to the user’s task list when signed in' do
    stub_signed_in_user
    get root_path

    expect(response.body).to include 'View your tasks'
  end
end
