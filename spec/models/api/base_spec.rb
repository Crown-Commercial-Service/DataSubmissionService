require 'rails_helper'

RSpec.describe API::Base do
  let(:dummy_api_model) do
    Class.new(API::Base) do
      # Boilerplate
      def self.name
        'dummy'
      end
    end
  end

  it 'includes the X-Auth-Id header in every request' do
    allow(Current).to receive(:auth_id).and_return('fake-auth-id')

    stub_request(:get, 'https://ccs.api/v1/dummies/1234')

    dummy_api_model.find('1234')

    expect(
      a_request(:get, 'https://ccs.api/v1/dummies/1234')
      .with(headers: { 'X-Auth-Id': 'fake-auth-id' })
    ).to have_been_made
  end
end
