module ApplicationHelper
  def framework_template_path_for(task)
    "/templates/#{task.framework.short_name.tr('/', '-')} MISO Data Template (August 2018).xls"
  end

  def support_email_address
    'dss@crowncommercial.gov.uk'
  end

  def task_status(task)
    task.status == 'completed' ? 'Task Completed' : "Due by #{task.due_on.to_date}"
  end

  def task_due_date(task)
    task.due_on.to_date
  end

  def task_month(task)
    Date.new(task.period_year, task.period_month).strftime('%B')
  end
end
