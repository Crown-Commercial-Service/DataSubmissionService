require 'rails_helper'

RSpec.feature 'Signing in as a user' do
  scenario 'Signing in successfully' do
    mock_sso_with(email: 'email@example.com')

    stub_request(:post, 'https://ccs.api/v1/events/user_signed_in')
      .with(query: hash_including(user_id: /.+/))
      .to_return(status: 201)

    visit '/tasks'

    click_on 'Sign in'

    expect(page).to have_flash_message 'You are now signed in'

    expect(
      a_request(:post, 'https://ccs.api/v1/events/user_signed_in')
      .with(query: hash_including(user_id: /.+/))
    ).to have_been_made.once
  end

  scenario 'Signing out' do
    mock_sso_with(email: 'email@example.com')

    stub_request(:post, 'https://ccs.api/v1/events/user_signed_in')
      .with(query: hash_including(user_id: /.+/))
      .to_return(status: 201)

    stub_request(:post, 'https://ccs.api/v1/events/user_signed_out')
      .with(query: hash_including(user_id: /.+/))
      .to_return(status: 201)

    visit '/tasks'
    click_on 'Sign in'
    click_on 'Sign out'

    expect(page).to have_flash_message 'You are now signed out'

    expect(
      a_request(:post, 'https://ccs.api/v1/events/user_signed_out')
      .with(query: hash_including(user_id: /.+/))
    ).to have_been_made.once
  end
end
