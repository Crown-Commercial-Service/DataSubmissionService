class TasksController < ApplicationController
  before_action :load_frameworks, :load_completed_tasks, :load_date_filter_values, only: [:history]

  def index
    @tasks = API::Task
             .select(submissions: %i[status submitted_at])
             .where(status: ['unstarted', 'in_progress', 'correcting'])
             .includes(:framework, :active_submission, :latest_submission)
             .all
             .sort_by { |t| [t.due_on, t.framework.name] }
  end

  def show
    @task = API::Task.includes(:framework, :past_submissions,
                               active_submission: %i[invoice_details files]).find(params[:id]).first
    @submission = @task.active_submission
    @file = @submission.files&.first
  end

  def complete; end

  def correct
    @task = API::Task.includes(:framework, active_submission: :files).find(params[:id]).first
    @submission = @task.active_submission
    @file = @submission.files&.first
  end

  def history
    @tasks.reverse! if params[:order_by] == 'Month (oldest)'
    @tasks = task_period_filter(@tasks) if params[:month_from]
    @paginated_tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(24)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def cancel_correction_confirmation
    @task = API::Task.includes(:framework, :active_submission).find(params[:id]).first

    redirect_to root_path unless @task.correcting?
  end

  def cancel_correction
    @task = API::Task.find(params[:id]).first
    redirect_to root_path unless @task.correcting?

    @task.cancel_correction
    redirect_to(
      task_path(@task),
      flash: { notice: 'You have successfully cancelled the correction.' }
    )
  end

  private

  def load_frameworks
    tasks = API::Task.where(status: 'completed').includes(:framework).all
    @frameworks = tasks.collect(&:framework).uniq.sort_by { |framework| framework.name.downcase }
  end

  def load_completed_tasks
    @tasks = API::Task
             .select(submissions: %i[status framework_id submitted_at invoice_total_value report_no_business?])
             .where(framework_id: params[:framework_id], status: 'completed')
             .includes(:framework, :active_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
             .reverse!
  end

  def task_period_filter(tasks)
    date_from = Date.new(params[:year_from].to_i, params[:month_from].to_i)
    date_to = Date.new(params[:year_to].to_i, params[:month_to].to_i)

    tasks.delete_if { |t| Date.new(t.period_year, t.period_month) < date_from }
    tasks.delete_if { |t| Date.new(t.period_year, t.period_month) > date_to }
  end

  def load_date_filter_values
    @completed_tasks = API::Task.where(status: 'completed').all.sort_by! { |t| Date.parse(t.due_on) }
  end
end
