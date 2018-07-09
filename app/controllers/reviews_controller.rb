class ReviewsController < ApplicationController
  def new
    @task = API::Task.includes(:framework).find(params[:task_id]).first

    @invoices_count = submission_entries.count { |e| e.source['sheet'].match?(/invoice/i) }
    @orders_count = submission_entries.count { |e| e.source['sheet'].match?(/order/i) }

    @validator = Validator.new(submission_entries: submission_entries)

    case @validator.status
    # if equal and all status is validated, display status
    when 'validated'
      flash.now[:notice] = 'All entries are valid'
    # if equal and atleast 1 status is errored, display errors
    when 'errored'
      flash.now[:alert] = "There are #{@validator.errors.count} errors"
    end
  end

  def create
    # NO OP
  end

  def processing
    # compare rows with entries count
    # if not equal, do nothing, keep polling
    redirect_to new_task_submission_review_path if ingest_entries_completed?
  end

  # JS endpoint for ingested entries status
  def ingest_status_polling
    render json: { complete: ingest_entries_completed? }
  end

  private

  def submission_entries
    submission = API::Submission.includes(:entries).find(params[:submission_id]).first
    submission.entries
  end

  def submission_file
    # TODO: I think we should find a less expensive way to get submission_file_id
    submission_file_id = submission_entries.first.submission_file_id
    @submission_file ||= API::SubmissionFile.where(submission_id: params[:submission_id]).find(submission_file_id).first
  end

  def expected_number_of_rows
    @expected_number_of_rows ||= submission_file.rows
  end

  def ingest_entries_completed?
    expected_number_of_rows == submission_entries.count
  end
end
