class TemplatesController < ApplicationController
  def show
    task = API::Task.includes(:framework).with_params(include_file: true).find(params[:task_id]).first

    if task.file_key.present?
      framework_template_file = s3_client.get_object(bucket: ENV['AWS_S3_BUCKET'], key: task.file_key)
      send_data framework_template_file.body.read, filename: template_filename_for_task_period(task)
    else
      framework_template_file = Rails.root.join('public', 'templates', "#{task.framework.safe_short_name}.xls")
      send_file framework_template_file, filename: template_filename_for_task_period(task)
    end
  end

  private

  def template_filename_for_task_period(task)
    "#{task.framework.safe_short_name} Data Template (#{task.reporting_period}).xls"
  end

  def s3_client
    @s3_client ||= Aws::S3::Client.new(region: ENV['AWS_S3_REGION'], stub_responses: Rails.env.test?)
  end
end
