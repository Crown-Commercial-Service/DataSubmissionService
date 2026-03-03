module API
  class User < Base
    custom_endpoint :update_name, on: :collection, request_method: :patch
  end
end
