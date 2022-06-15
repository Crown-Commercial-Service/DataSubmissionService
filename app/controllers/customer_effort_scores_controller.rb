class CustomerEffortScoresController < ApplicationController
  def create
    pp "params-------"
    pp params
    API::CustomerEffortScore.create(
      rating: params[:customer_satisfaction], 
      comments: params[:more_detail], 
      user_id: current_user.id
      )

      # redirect_to
  end
end