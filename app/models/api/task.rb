module API
  class Task < Base
    has_one :framework
    has_one :latest_submission, class_name: 'API::Submission'

    custom_endpoint :no_business, on: :member, request_method: :post

    def complete?
      status == 'completed'
    end

    def errors?
      (latest_submission.try(:status) == 'validation_failed') || false
    end

    def late?
      !complete? && due_on.to_date < Time.zone.today
    end

    def period_month_name
      Date::MONTHNAMES[period_month]
    end
  end
end
