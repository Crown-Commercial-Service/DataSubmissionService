module RequestSpecHelpers
  def stub_signed_in_user
    FactoryBot.create(:user).tap do |user|
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
  end
end
