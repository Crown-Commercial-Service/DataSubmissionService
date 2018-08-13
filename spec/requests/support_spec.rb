require 'rails_helper'

RSpec.describe 'the support page' do
  it 'dispay support information, including the support email address' do
    get support_path

    expect(response).to be_successful
    expect(response.body).to include('Support')
    expect(response.body).to include('dss@crowncommercial.gov.uk')
  end
end