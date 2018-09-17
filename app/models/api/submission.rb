module API
  class Submission < Base
    has_many :entries, class_name: 'SubmissionEntry'
    has_many :files, class_name: 'SubmissionFile'
    has_one :task

    # GET /submissions/:id/calculate
    custom_endpoint :calculate, on: :member, request_method: :post

    # POST /submissions/:id/complete
    custom_endpoint :complete, on: :member, request_method: :post

    def errored_entries
      @errored_entries ||= entries.select { |entry| entry.status == 'errored' }
    end
  end
end
