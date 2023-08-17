class UrnsController < ApplicationController
  def index
    @customers = API::Customer.where(search: params[:search]).page(params[:page]).all
    @pagination_info = @customers.meta[:pagination]
    @customers = Kaminari.paginate_array(@customers,
                                         total_count: @pagination_info[:total]).page(@pagination_info[:current_page])
  end
end
