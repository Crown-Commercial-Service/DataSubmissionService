module RequestSpecHelpers
  def stub_signed_in_user
    allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return('eyJhbGciOiJIUzI1NiJ9.ImF1dGgwfDEyMzQ1NiI.-MroB4ActYlc-0-XG1UrdbdDfhY0MbD86TMdLv4P5ig')
  end
end
