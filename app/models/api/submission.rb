module API
  class Submission < Base
    has_many :entries, class_name: 'SubmissionEntry'
    has_many :files, class_name: 'SubmissionFile'

    # GET /submissions/:id/calculate
    custom_endpoint :calculate, on: :member, request_method: :get
  end
end
