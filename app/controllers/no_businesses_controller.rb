class NoBusinessesController < ApplicationController
  before_action :load_task

  def new; end

  def create
    submission = @task.no_business.first
    redirect_to task_submission_path(task_id: @task.id, id: submission.id)
  end

  private

  def load_task
    @task = API::Task.includes(:framework).find(params[:task_id]).first
  end
end
