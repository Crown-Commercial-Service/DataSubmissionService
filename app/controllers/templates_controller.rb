class TemplatesController < ApplicationController
  def show
    task = API::Task.includes(:framework).find(params[:task_id]).first
    framework_template_file = Rails.root.join('public', 'templates', "#{task.framework.safe_short_name}.xls")
    send_file framework_template_file, filename: template_filename_for_task_period(task)
  end

  private

  def template_filename_for_task_period(task)
    "#{task.framework.safe_short_name} MISO Data Template (#{Date::MONTHNAMES[task.period_month]} #{task.period_year}).xls"
  end
end
