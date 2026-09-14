class InactiveUrnsController < ApplicationController
  def index
    @inactive_customers = API::InactiveCustomer.where(search: params[:search]).page(params[:page]).all
    @pagination_info = @inactive_customers.meta[:pagination]
    @inactive_customers = Kaminari.paginate_array(@inactive_customers,
                                                  total_count: @pagination_info[:total])
                                  .page(@pagination_info[:current_page])
  end
end
