require 'rails_helper'

RSpec.describe 'the template for a task' do
  around(:each) do |example|
    ClimateControl.modify AWS_S3_BUCKET: 'bucket-name', AWS_S3_REGION: 'zz-north-1' do
      example.run
    end
  end

  context 'when file key exists' do
    it 'returns the template file named with the month of the task' do
      stub_signed_in_user
      mock_task_with_framework_and_file_endpoint!
      get task_template_path(mock_task_id)
      expect(response).to be_successful
      expected_disposition = 'attachment; filename="CBOARD5 Data Template (July 2018).xls"'
      expect(response.headers['Content-Disposition']).to eq(expected_disposition)
    end
  end

  context 'when file key is nil' do
    it 'returns the template file named with the month of the task' do
      stub_signed_in_user
      mock_task_with_framework_endpoint!(include_file: true)
      get task_template_path(mock_task_id)
      expect(response).to be_successful
      expected_disposition = 'attachment; filename="CBOARD5 Data Template (July 2018).xls"'
      expect(response.headers['Content-Disposition']).to eq(expected_disposition)
    end
  end

  it 'santitizes the file name' do
    stub_signed_in_user
    mock_task_with_unsafe_short_name_framework_endpoint!(include_file: true)
    get task_template_path(mock_task_id)
    expect(response).to be_successful
    expected_disposition = 'attachment; filename="CBOARD-5 Data Template (July 2018).xls"'
    expect(response.headers['Content-Disposition']).to eq(expected_disposition)
  end
end
