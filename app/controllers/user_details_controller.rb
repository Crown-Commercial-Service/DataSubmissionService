class UserDetailsController < ApplicationController
  def show
    @suppliers = API::Supplier.all
  end

  def edit; end

  def update
    new_name = params[:name]

    api_response = API::User.update_name(name: new_name)

    if api_response.any?
      redirect_to user_detail_path, notice: 'Your name has been updated successfully.'
    else
      flash.now[:alert] = 'There was a problem updating your name. Please try again.'
      render :edit, status: :unprocessable_entity
    end
  rescue JSONAPI::Consumer::Errors::ConnectionError
    flash.now[:alert] = 'There was a problem connecting to the user service. Please try again later.'
    render :edit, status: :service_unavailable
  end
end
