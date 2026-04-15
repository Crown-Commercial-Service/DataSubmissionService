# app/models/api/email_verification.rb
module API
  class EmailVerification < Base
    custom_endpoint :verify_token, on: :collection, request_method: :post
    custom_endpoint :active_verification, on: :collection, request_method: :get
    custom_endpoint :cancel_pending_email_change, on: :collection, request_method: :delete

    def self.verify_email(tokened:)
      response = verify_token({ token: tokened })
      response&.any?
    rescue JSONAPI::Consumer::Errors::NotFound, JSONAPI::Consumer::Errors::ConnectionError
      false
    end

    def self.email_verification_pending?
      response = active_verification
      response&.first
    rescue JSONAPI::Consumer::Errors::NotFound, JSONAPI::Consumer::Errors::ConnectionError
      nil
    end

    def self.delete_pending_email_change
      cancel_pending_email_change
      true
    rescue JSONAPI::Consumer::Errors::NotFound, JSONAPI::Consumer::Errors::ConnectionError
      false
    end
  end
end
