class UrnsController < ApplicationController
  def index
    @customers = API::Customer.where(search: params[:search]).all

    @customers = Kaminari.paginate_array(@customers).page(params[:page])
  end
end
