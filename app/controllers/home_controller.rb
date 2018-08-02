class HomeController < ApplicationController
  def index
    if current_user
      render :signed_in_homepage
    else
      render :guest_homepage
    end
  end
end
