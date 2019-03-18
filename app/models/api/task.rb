module API
  class Task < Base
    has_one :framework
    has_one :active_submission, class_name: 'API::Submission'
    has_one :latest_submission, class_name: 'API::Submission'

    custom_endpoint :no_business, on: :member, request_method: :post

    def complete?
      status == 'completed'
    end

    def errors?
      (active_submission.try(:status) == 'validation_failed') || false
    end

    def late?
      !complete? && due_on.to_date < Time.zone.today
    end

    def correcting?
      status == 'correcting'
    end

    def reporting_period
      [Date::MONTHNAMES[period_month], period_year].join(' ')
    end

    def completed_at
      return unless active_submission.submitted_at

      Time.zone.parse(active_submission.submitted_at).to_s(:date_with_utc_time)
    end
  end
end
