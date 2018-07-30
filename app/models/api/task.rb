module API
  class Task < Base
    has_one :framework

    # POST /tasks/:id/complete
    custom_endpoint :complete, on: :member, request_method: :post
    custom_endpoint :no_business, on: :member, request_method: :post
  end
end
