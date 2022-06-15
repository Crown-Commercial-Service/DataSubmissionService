class CustomerEffortScoresController < ApplicationController
  def create
    API::CustomerEffortScore.create(
      rating: params[:customer_satisfaction],
      comments: params[:more_detail],
      user_id: current_user.id
    )
  end
end
