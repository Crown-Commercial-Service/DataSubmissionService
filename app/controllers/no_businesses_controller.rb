class NoBusinessesController < ApplicationController
  before_action :load_task

  def new; end

  def create
    if correction?
      submission = @task.no_business(correction: 'true').first
      redirect_to task_submission_path(task_id: @task.id, id: submission.id, correction: true)
    else
      submission = @task.no_business.first
      redirect_to task_submission_path(task_id: @task.id, id: submission.id)
    end
  end

  private

  def load_task
    @task = API::Task.includes(:framework).find(params[:task_id]).first
  end
end
