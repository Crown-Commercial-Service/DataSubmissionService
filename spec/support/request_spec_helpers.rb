module RequestSpecHelpers
  def stub_signed_in_user
    allow_any_instance_of(ApplicationController).to receive(:current_user_id)
      .and_return(JWT.encode('auth0|123456', 'test'))
  end
end
