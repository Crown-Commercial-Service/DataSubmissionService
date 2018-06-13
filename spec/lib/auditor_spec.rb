require 'rails_helper'

RSpec.describe Auditor do
  describe '.user_signed_in' do
    it 'posts a sign in event to the API' do
      stub_request(:post, 'https://ccs.api/v1/events/user_signed_in')
        .with(query: hash_including(user_id: /.+/))
        .to_return(status: 201)

      Auditor.new.user_signed_in(user_id: '1234')

      expect(
        a_request(:post, 'https://ccs.api/v1/events/user_signed_in')
        .with(query: { user_id: '1234' })
      ).to have_been_made.once
    end
  end

  describe '.user_signed_out' do
    it 'posts a sign out event to the API' do
      stub_request(:post, 'https://ccs.api/v1/events/user_signed_out')
        .with(query: hash_including(user_id: /.+/))
        .to_return(status: 201)

      Auditor.new.user_signed_out(user_id: '5678')

      expect(
        a_request(:post, 'https://ccs.api/v1/events/user_signed_out')
        .with(query: { user_id: '5678' })
      ).to have_been_made.once
    end
  end
end
