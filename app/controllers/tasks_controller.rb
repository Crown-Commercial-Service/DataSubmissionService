class TasksController < ApplicationController
  def index
    tasks = API::Task
            .where(auth_id: current_user_id)
            .includes(:framework, :latest_submission)
            .all
            .sort_by! { |t| Date.parse(t.due_on) }

    # Move completed tasks to the bottom
    completed_tasks = tasks.select { |t| t.status == 'completed' }
    @tasks = (tasks - completed_tasks) + completed_tasks
  end

  def complete; end
end
