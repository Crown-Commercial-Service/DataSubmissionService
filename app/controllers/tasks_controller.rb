class TasksController < ApplicationController
  def index
    @tasks = API::Task
             .select(submissions: %i[status submitted_at])
             .where(status: ['unstarted', 'in_progress'])
             .includes(:framework, :latest_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
  end

  def show
    @task = API::Task.includes(:framework, latest_submission: :files).find(params[:id]).first
    @submission = @task.latest_submission
    @file = @submission.files&.first
  end

  def complete; end

  def correct
    @task = API::Task.includes(:framework, latest_submission: :files).find(params[:id]).first
    @submission = @task.latest_submission
    @file = @submission.files&.first
  end

  def history
    @tasks = API::Task
             .select(submissions: %i[status submitted_at])
             .where(status: 'completed')
             .includes(:framework, :latest_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
  end
end
