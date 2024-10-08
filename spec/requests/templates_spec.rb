require 'rails_helper'

RSpec.describe 'downloading a template' do
  around(:each) do |example|
    ClimateControl.modify AWS_S3_BUCKET: 'bucket-name', AWS_S3_REGION: 'zz-north-1' do
      example.run
    end
  end

  before do
    mock_notifications_endpoint!
  end

  context 'when file key exists' do
    it 'returns the template file named with the month of the task' do
      stub_signed_in_user
      mock_task_with_framework_and_file_endpoint!
      get template_path(id: mock_task_id)
      expect(response).to be_successful
      expected_disposition = "filename*=UTF-8''CBOARD5%20Data%20Template%20%28July%202018%29.xls"
      expect(response.headers['Content-Disposition']).to include(expected_disposition)
    end
  end

  context 'when downloading from the agreements page' do
    it 'returns the template file named with the framework short name' do
      stub_signed_in_user
      mock_framework_and_file_endpoint!
      get template_path(id: mock_framework_id, agreements_page: true)
      expect(response).to be_successful
      expected_disposition = 'attachment; filename="cboard12 Data Template"'
      expect(response.headers['Content-Disposition']).to include(expected_disposition)
    end

    it 'santitizes the file name' do
      stub_signed_in_user
      mock_framework_and_file_with_unsafe_short_name_endpoint!
      get template_path(id: mock_framework_id, agreements_page: true)
      expect(response).to be_successful
      expected_disposition = 'attachment; filename="cboard-12 Data Template"'
      expect(response.headers['Content-Disposition']).to include(expected_disposition)
    end
  end

  context 'when file key is nil' do
    it 'returns the template file named with the month of the task' do
      stub_signed_in_user
      mock_task_with_framework_endpoint!(include_file: true)
      get template_path(id: mock_task_id)
      expect(response).to be_successful
      expected_disposition = "filename*=UTF-8''CBOARD5%20Data%20Template%20%28July%202018%29.xls"
      expect(response.headers['Content-Disposition']).to include(expected_disposition)
    end
  end

  it 'santitizes the file name' do
    stub_signed_in_user
    mock_task_with_unsafe_short_name_framework_endpoint!(include_file: true)
    get template_path(id: mock_task_id)
    expect(response).to be_successful
    expected_disposition = "filename*=UTF-8''CBOARD-5%20Data%20Template%20%28July%202018%29.xls"
    expect(response.headers['Content-Disposition']).to include(expected_disposition)
  end
end
