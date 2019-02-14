class TasksController < ApplicationController
  def index
    @tasks = API::Task
             .where(auth_id: current_user_id, status: ['unstarted', 'in_progress'])
             .includes(:framework, :latest_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
  end

  def complete; end
end
