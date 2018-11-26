module RequestSpecHelpers
  def stub_signed_in_user
    allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return('auth0|123456')
  end
end
