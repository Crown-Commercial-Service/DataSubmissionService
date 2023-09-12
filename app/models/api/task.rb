module API
  class Task < Base
    has_one :framework
    has_one :active_submission, class_name: 'API::Submission'
    has_one :latest_submission, class_name: 'API::Submission'

    custom_endpoint :no_business, on: :member, request_method: :post
    custom_endpoint :cancel_correction, on: :member, request_method: :patch

    def complete?
      status == 'completed'
    end

    def errors?
      error_statuses = %w[validation_failed ingest_failed management_charge_calculation_failed]
      error_statuses.include?(active_submission&.status) || error_statuses.include?(latest_submission&.status)
    end

    def late?
      !complete? && due_on.to_date < Time.zone.today
    end

    def correcting?
      status == 'correcting'
    end

    def unstarted?
      status == 'unstarted'
    end

    def no_business_active_submission
      active_submission && active_submission.report_no_business? == true
    end

    def reporting_period
      [Date::MONTHNAMES[period_month], period_year].join(' ')
    end

    def completed_at
      return unless active_submission.submitted_at

      Time.zone.parse(active_submission.submitted_at).to_fs(:date_with_utc_time)
    end

    def can_report_no_business?
      unstarted? || !no_business_active_submission
    end
  end
end
