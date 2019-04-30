require 'rails_helper'

RSpec.describe 'support-rooted pages' do
  describe 'the support page' do
    it 'dispay support information, including the support email address' do
      get support_path

      expect(response).to be_successful
      expect(response.body).to include('Support')
      expect(response.body).to include('report-mi@crowncommercial.gov.uk')
    end
  end

  describe 'the frameworks list' do
    before do
      mock_frameworks_endpoint!
    end

    it 'displays frameworks from the API' do
      get support_frameworks_path

      expect(response.body).to include('FM1001')
      expect(response.body).to include('G Cloud 1')
      expect(response.body).to include('FM1002')
      expect(response.body).to include('G Cloud 2')
    end
  end
end
