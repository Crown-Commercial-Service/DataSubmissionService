class TemplatesController < ApplicationController
  def show
    resp = call_api

    if resp.file_key.present?
      framework_template_file = s3_client.get_object(bucket: ENV['AWS_S3_BUCKET'], key: resp.file_key)
      file_extension = File.extname(resp.file_name)
      send_data framework_template_file.body.read, filename: template_filename(resp, file_extension)
    else
      framework_template_file = Rails.root.join('public', 'templates', "#{framework_short_name(resp)}.xls")
      file_extension = '.xls'
      send_file framework_template_file, filename: template_filename(resp, file_extension)
    end
  end

  private

  def call_api
    if params[:agreements_page]
      API::Framework.with_params(include_file: true).find(params[:id]).first
    else
      API::Task.includes(:framework).with_params(include_file: true).find(params[:id]).first
    end
  end

  def framework_short_name(resp)
    if params[:agreements_page]
      resp.safe_short_name
    else
      resp.framework.safe_short_name
    end
  end

  def template_filename(resp, file_extension)
    if params[:agreements_page]
      "#{resp.safe_short_name} Data Template#{file_extension}"
    else
      "#{resp.framework.safe_short_name} Data Template (#{resp.reporting_period})#{file_extension}"
    end
  end

  def s3_client
    @s3_client ||= Aws::S3::Client.new(region: ENV['AWS_S3_REGION'], stub_responses: Rails.env.test?)
  end
end
