class TasksController < ApplicationController
  def index
    @tasks = API::Task
             .where(status: ['unstarted', 'in_progress'])
             .includes(:framework, :latest_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
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
