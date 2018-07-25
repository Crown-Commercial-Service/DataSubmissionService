module API
  class Submission < Base
    has_many :entries, class_name: 'SubmissionEntry'
    has_many :files, class_name: 'SubmissionFile'

    # GET /submissions/:id/calculate
    custom_endpoint :calculate, on: :member, request_method: :post

    def orders_count
      entries.count { |entry| entry.source['sheet'].match?(/order/i) }
    end

    def invoices_count
      entries.count { |entry| entry.source['sheet'].match?(/invoice/i) }
    end

    def errored_entries
      @errored_entries ||= entries.select { |entry| entry.status == 'errored' }
    end
  end
end
