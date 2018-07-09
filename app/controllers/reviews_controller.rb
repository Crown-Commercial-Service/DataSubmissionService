class ReviewsController < ApplicationController
  def new
    @task = API::Task.includes(:framework).find(params[:task_id]).first

    @invoices_count = submission_entries.count { |e| e.source['sheet'].match?(/invoice/i) }
    @orders_count = submission_entries.count { |e| e.source['sheet'].match?(/order/i) }

    @validator = Validator.new(submission_entries: submission_entries)

    case @validator.status
    when 'validated'
      flash.now[:notice] = 'All entries are valid'
    when 'errored'
      flash.now[:alert] = "There are #{@validator.errors.count} errors in the uploaded spreadsheet"
    end
  end

  def create
    render 'tasks/complete'
  end

  def processing
    redirect_to new_task_submission_review_path if ingest_entries_completed?
  end

  def ingest_status_polling
    render json: { complete: ingest_entries_completed? }
  end

  private

  def submission_entries
    submission = API::Submission.includes(:entries).find(params[:submission_id]).first
    submission.entries
  end

  def submission_file
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
