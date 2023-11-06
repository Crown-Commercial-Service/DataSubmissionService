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

  def about_cookies_url
    'http://www.aboutcookies.org/'
  end

  def cookie_preferences
    JSON.parse(cookies[:cookie_preferences]) if cookies[:cookie_preferences]
  end

  def ga_cookie_permission
    cookie_preferences['usage'] if cookie_preferences
  end

  def glassbox_cookie_permission
    cookie_preferences['glassbox'] if cookie_preferences
  end
end
