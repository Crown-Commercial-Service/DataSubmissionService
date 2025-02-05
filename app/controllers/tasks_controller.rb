class TasksController < ApplicationController
  before_action :load_frameworks, :load_date_filter_values, only: [:history]

  def index
    @unstarted_tasks = API::Task.where(status: 'unstarted').all
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
    @tasks = API::Task
             .select(submissions: %i[status framework_id submitted_at invoice_total_value report_no_business?])
             .where(framework_id: params[:framework_id], status: 'completed')
             .where(task_period: task_period_date_range, sort_order: sort_order, pagination_required: true)
             .includes(:framework, :active_submission)
             .page(params[:page])
             .all

    @pagination_info = @tasks.meta[:pagination]
    # rubocop:disable Metrics/LineLength
    @paginated_tasks = Kaminari.paginate_array(@tasks,
                                               total_count: @pagination_info[:total]).page(@pagination_info[:current_page]).per(@pagination_info[:per_page])
    # rubocop:enable Metrics/LineLength

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

  def load_date_filter_values
    @completed_tasks = API::Task.where(status: 'completed').all.sort_by! { |t| Date.parse(t.due_on) }
  end

  def task_period_date_range
    date_from = if params[:year_from]
                  Date.new(params[:year_from].to_i,
                           params[:month_from].to_i)
                else
                  Date.new(1899, 12, 30)
                end
    date_to = params[:year_to] ? Date.new(params[:year_to].to_i, params[:month_to].to_i) : Time.zone.today
    [date_from, date_to]
  end

  def sort_order
    if params[:order_by] && params[:order_by] == 'Month (oldest)'
      :asc
    else
      :desc
    end
  end
end
