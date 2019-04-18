class SupportController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def index; end

  def frameworks
    # API::Framework.all returns only published frameworks
    @frameworks = API::Framework.all
  end
end
