module API
  class User < Base
    custom_endpoint :update_name, on: :collection, request_method: :patch
    custom_endpoint :update_email, on: :collection, request_method: :patch
    custom_endpoint :user_auth_logs, on: :collection, request_method: :get
  end
end
