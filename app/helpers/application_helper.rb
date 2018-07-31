module ApplicationHelper
  def framework_template_path_for(task)
    "/templates/#{task.framework.short_name} MISO Data Template (July 2018).xls"
  end

  def support_email_address
    'dss@crowncommercial.gov.uk'
  end

  def levy_as_string(levy_in_pence)
    levy_in_pounds = BigDecimal(levy_in_pence) / 100
    number_to_currency(levy_in_pounds, unit: '£')
  end

  def task_status(task)
    task.status == 'completed' ? 'Task Completed' : "Due by #{task.due_on.to_date}"
  end

  def task_period_date(task)
    Date.new(task.period_year, task.period_month).to_s(:month_year)
  end
end
