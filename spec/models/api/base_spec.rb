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
    allow(Current).to receive(:jwt).and_return('fake-jwt')

    stub_request(:get, api_url('dummies/1234'))

    dummy_api_model.find('1234')

    expect(
      a_request(:get, api_url('dummies/1234'))
      .with(headers: { 'Authorization': 'Bearer fake-jwt' })
    ).to have_been_made
  end
end
