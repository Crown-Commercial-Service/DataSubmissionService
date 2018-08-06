class HomeController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def index
    if current_user
      render :signed_in_homepage
    else
      render :guest_homepage
    end
  end
end
