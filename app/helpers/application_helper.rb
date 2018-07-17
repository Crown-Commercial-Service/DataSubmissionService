module ApplicationHelper
  def framework_template_url_for(task_id:)
    framework = API::Task.includes(:framework).find(task_id).first.try(:framework)

    return if framework.nil?

    "/templates/#{framework.short_name} MISO Data Template (July 2018).xls"
  end
end
