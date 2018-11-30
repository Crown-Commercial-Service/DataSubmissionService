require 'rails_helper'

RSpec.describe 'the urns page' do
  it 'has a link to download the URNs file' do
    stub_signed_in_user

    get urns_path

    expect(response).to be_successful
    assert_select 'a[href=?]', '/urn/CCS-URN-List-(29-November-2018).xls',
                  text: 'Download CCS URN List (29 November 2018).xls'
  end
end
