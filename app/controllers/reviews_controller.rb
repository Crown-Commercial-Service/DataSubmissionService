class ReviewsController < ApplicationController
  def new
    @task = API::Task.includes(:framework).find(params[:task_id]).first
  end

  def create
    # NO OP
  end
end
