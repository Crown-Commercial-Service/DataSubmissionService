require 'rails_helper'

RSpec.describe 'the customers list' do
  it 'refuses users that are not signed in' do
    get urns_path

    expect(response).to redirect_to(root_path)
  end

  context 'when signed-in as a user' do
    before do
      mock_customers_endpoint!
      mock_notifications_endpoint!
      stub_signed_in_user
      get urns_path
    end

    it 'lists the customers with URNs' do
      expect(response).to be_successful
      expect(response.body).to include '62221732'
      expect(response.body).to include 'A Random Customer'
      expect(response.body).to include 'Wider Public Sector'
      expect(response.body).to include 'WC2R 1HG'
      expect(response.body).to include '82618604'
      expect(response.body).to include 'Crikey Another Customer'
      expect(response.body).to include 'Central Government'
      expect(response.body).to include 'LL26 0YF'
      expect(response.body).to include 'Displaying <b>all 6</b> customers'
    end
  end
end
