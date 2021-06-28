class TasksController < ApplicationController
  def index
    @tasks = API::Task
             .select(submissions: %i[status submitted_at])
             .where(status: ['unstarted', 'in_progress', 'correcting'])
             .includes(:framework, :active_submission, :latest_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
  end

  def show
    @task = API::Task.includes(:framework, active_submission: :files).find(params[:id]).first
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
    load_frameworks

    @tasks = API::Task
             .select(submissions: %i[status framework_id submitted_at invoice_total_value report_no_business?])
             .where(framework_id: params[:framework_id], status: 'completed')
             .includes(:framework, :active_submission)
             .all
             .sort_by! { |t| Date.parse(t.due_on) }
             .reverse!

    @tasks.reverse! if (params[:order_by]) == 'Month (oldest)'
    @tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(24)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def cancel_correction_confirmation
    @task = API::Task.includes(:framework).find(params[:id]).first

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
    @tasks = API::Task.where(status: 'completed').includes(:framework).all
    @frameworks = @tasks.collect(&:framework).uniq.sort_by {|framework| framework.name.downcase}
  end
end
