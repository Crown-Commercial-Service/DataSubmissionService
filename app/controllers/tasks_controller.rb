class TasksController < ApplicationController
  def index
    @tasks = API::Task
             .where(status: ['unstarted', 'in_progress'])
             .includes(:framework, :latest_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
  end

  def show
    @task = API::Task.includes(:framework, :latest_submission).find(params[:id]).first
    @submission = @task.latest_submission
  end

  def complete; end

  def history
    @tasks = API::Task
             .where(status: 'completed')
             .includes(:framework, :latest_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
  end
end
