require 'rails_helper'

RSpec.describe 'the template for a task' do
  it 'returns the template file named with the month of the task' do
    stub_signed_in_user
    mock_task_with_framework_endpoint!
    get task_template_path(mock_task_id)
    expect(response).to be_successful
    expected_disposition = 'attachment; filename="CBOARD5 MISO Data Template (July 2018).xls"'
    expect(response.headers['Content-Disposition']).to eq(expected_disposition)
  end

  it 'santitizes the file name' do
    stub_signed_in_user
    mock_task_with_unsafe_short_name_framework_endpoint!
    get task_template_path(mock_task_id)
    expect(response).to be_successful
    expected_disposition = 'attachment; filename="CBOARD-5 MISO Data Template (July 2018).xls"'
    expect(response.headers['Content-Disposition']).to eq(expected_disposition)
  end
end
