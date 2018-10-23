class SupportController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def index; end

  def frameworks
    render :frameworks
  end
end
