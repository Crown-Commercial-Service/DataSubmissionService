require 'rails_helper'

RSpec.describe 'giving feedback' do
  before do
    mock_task_with_framework_endpoint!
    mock_no_business_endpoint!
    mock_customer_effort_score_endpoint!
    mock_user_endpoint!
  end

  it 'submits score and any comments to the api' do
    stub_signed_in_user
    post customer_effort_score_path

    expect(response).to be_successful
  end
end
