module ApplicationHelper
  def framework_template_url_for(task_id:)
    framework = API::Task.includes(:framework).find(task_id).first.try(:framework)

    return if framework.nil?

    "/templates/#{framework.short_name} MISO Data Template (July 2018).xls"
  end

  def support_email_address
    'dss@crowncommercial.gov.uk'
  end

  def levy_as_string(levy_in_pence)
    levy_in_pounds = BigDecimal(levy_in_pence) / 100
    number_to_currency(levy_in_pounds, unit: '£')
  end

  def task_status(task)
    task.status == 'completed' ? 'Complete' : "Due by #{task.due_on}"
  end
end
