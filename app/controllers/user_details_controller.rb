class UserDetailsController < ApplicationController
  def show
    @suppliers = API::Supplier.all
  end
end
