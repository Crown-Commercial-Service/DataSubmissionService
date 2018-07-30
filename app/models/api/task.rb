module API
  class Task < Base
    has_one :framework

    custom_endpoint :no_business, on: :member, request_method: :post
  end
end
