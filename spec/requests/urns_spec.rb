require 'rails_helper'

RSpec.describe 'the urns page' do
  around(:each) do |example|
    ClimateControl.modify AWS_S3_BUCKET: 'bucket-name', AWS_S3_REGION: 'zz-north-1' do
      example.run
    end
  end

  it 'has a link to download the URNs file' do
    stub_signed_in_user
    mock_urn_lists_endpoint!

    get urns_path

    expect(response).to be_successful
    assert_select 'a[href=?]', '/urns/download',
                  text: 'Download CCS URN List (20 May 2019).xls'
  end

  context 'when file key exists' do
    it 'returns the URN list' do
      stub_signed_in_user
      mock_urn_lists_endpoint!

      get download_urns_path

      expect(response).to be_successful
      expected_disposition = 'attachment; filename="CCS URN List (20 May 2019).xls"'
      expect(response.headers['Content-Disposition']).to eq(expected_disposition)
    end
  end

  context 'when there are no acceptable URN lists' do
    it 'returns an older URN list from the filesystem' do
      stub_signed_in_user
      mock_empty_urn_lists_endpoint!

      get download_urns_path

      expect(response).to be_successful
      expected_disposition = 'attachment; filename="CCS-URN-List-(27-March-2019).xls"'
      expect(response.headers['Content-Disposition']).to eq(expected_disposition)
    end
  end
end
