class UrnsController < ApplicationController
  def show
    @urn_list = API::UrnList.first
  end

  def download
    urn_list = API::UrnList.first

    if urn_list.present?
      urn_list_file = s3_client.get_object(bucket: ENV['AWS_S3_BUCKET'], key: urn_list.file_key)
      send_data urn_list_file.body.read, filename: urn_list.filename
    else
      urn_list_file = Rails.root.join('public', 'urn', 'CCS-URN-List-(27-March-2019).xls')
      send_file urn_list_file, filename: 'CCS-URN-List-(27-March-2019).xls'
    end
  end

  private

  def s3_client
    @s3_client ||= Aws::S3::Client.new(region: ENV['AWS_S3_REGION'], stub_responses: Rails.env.test?)
  end
end
