module ApplicationHelper
  def support_email_address
    'report-mi@crowncommercial.gov.uk'
  end

  def finance_email_address
    'ccsfinance@crowncommercial.gov.uk'
  end

  def task_status(task)
    task.status == 'completed' ? 'Task Completed' : "Due by #{task.due_on.to_date}"
  end

  def task_due_date(task)
    task.due_on.to_date
  end

  def page_title(title)
    content_for :page_title, title
  end

  def correction_returns_enabled?
    ENV['CORRECTION_RETURNS_ENABLED'].present?
  end

  def survey_url
    'https://crowncommercial.qualtrics.com/jfe/form/SV_7a44L3eBrOGDCVU'
  end
end
