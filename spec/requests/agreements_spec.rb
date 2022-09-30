require 'rails_helper'

RSpec.describe 'the agreements list' do
  around(:each) do |example|
    ClimateControl.modify AWS_S3_BUCKET: 'bucket-name', AWS_S3_REGION: 'zz-north-1' do
      example.run
    end
  end

  it 'refuses users that are not signed in' do
    get agreements_path

    expect(response).to redirect_to(root_path)
  end

  context 'when signed-in as a user with agreements' do
    before do
      mock_agreements_with_framework_and_supplier_endpoint!
      mock_user_with_multiple_suppliers_endpoint!
      stub_signed_in_user
      get agreements_path
    end

    it 'lists the suppliers’ agreements' do
      expect(response).to be_successful
      expect(response.body).to include 'CBOARD5'
      expect(response.body).to include 'Lot 1: Gorgonzola'
      expect(response.body).to include 'Active'
      expect(response.body).to include 'cboard12'
      expect(response.body).to include 'Lot 4: Halloumi'
      expect(response.body).to include 'Inactive'
    end

    it 'includes the supplier names if user is linked to multiple' do
        expect(response).to be_successful
        expect(response.body).to include 'Bobs Cheese Shop'
        expect(response.body).to include 'Test Ltd'
      end
  

    it 'links to the template for a framework' do
      cboard5_agreement_id = '7382e0e7-e15e-4d9e-82b5-df0dfde2a62d'
      cboard5_framework_id = 'f87717d4-874a-43d9-b99f-c8cf2897b526'
  
      assert_select "#agreement-#{cboard5_agreement_id}" do
        assert_select 'a[href=?]',
                      template_path(id: cboard5_framework_id, agreements_page: true),
                      text: 'Download template (excel document)'
      end
    end
  end
end