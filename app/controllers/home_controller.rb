class HomeController < ApplicationController
  skip_before_action :ensure_user_signed_in

  def index
    if current_user_id
      redirect_to tasks_path
    else
      render :guest_homepage
    end
  end

  def cookie_policy
    render :cookie_policy
  end

  def cookie_settings
    render :cookie_settings
  end
end
