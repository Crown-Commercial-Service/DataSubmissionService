class ReviewsController < ApplicationController
  before_action :set_task, only: %i[new create]
  def new
    @invoices_count = submission_entries.count { |e| e.source['sheet'].match?(/invoice/i) }
    @orders_count = submission_entries.count { |e| e.source['sheet'].match?(/order/i) }

    case validator.status
    when 'validated'
      flash.now[:notice] = 'All entries are valid'
    when 'errored'
      flash.now[:alert] = "There are #{@validator.errors.count} errors in the uploaded spreadsheet"
    end
  end

  def create
    @submission = submission
    @submission.status = 'completed'

    if @submission.save
      mark_task_as_completed
      flash.now[:notice] = 'You have successfully submitted your return'
    else
      flash.now[:alert] = 'Submission failed'
    end
    render :create
  end

  def processing
    case params[:state]
    when 'ingest'
      @polling_url = task_submission_review_ingest_status_polling_path
      ingest_processing
    when 'calculate'
      submission.calculate
      @polling_url = task_submission_review_calculate_status_polling_path
      calculate_processing
    end
  end

  def ingest_processing
    redirect_to new_task_submission_review_path if ingest_entries_completed?
  end

  def calculate_processing
    redirect_to new_task_submission_review_path if levy_calculation_completed?
  end

  def ingest_status_polling
    render json: { complete: ingest_entries_completed? }
  end

  def calculate_status_polling
    render json: { complete: levy_calculation_completed? }
  end

  private

  def set_task
    @task = API::Task.includes(:framework).find(params[:task_id]).first
  end

  def submission
    @submission ||= API::Submission.includes(:files, :entries).find(params[:submission_id]).first
  end

  def submission_entries
    @submission_entries ||= submission.entries
  end

  def submission_file
    @submission_file ||= submission.files.try(:first)
  end

  def expected_number_of_rows
    @expected_number_of_rows ||= submission_file.try(:rows)
  end

  def ingest_entries_completed?
    return false if validator.pending?

    expected_number_of_rows == submission_entries.count
  end

  def levy_calculation_completed?
    submission.status == 'completed'
  end

  def validator
    @validator ||= Validator.new(submission: submission)
  end

  def mark_task_as_completed
    @task.complete
  end
end
