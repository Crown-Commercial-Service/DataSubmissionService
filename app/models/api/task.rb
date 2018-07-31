module API
  class Task < Base
    has_one :framework
    has_one :latest_submission, class_name: 'API::Submission'

    custom_endpoint :no_business, on: :member, request_method: :post
  end
end
