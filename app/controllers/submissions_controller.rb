class SubmissionsController < ApplicationController
  before_action :ensure_user_signed_in
  before_action :validate_file_presence_and_content_type, only: [:create]

  def new
    @task = API::Task.includes(:framework).find(params[:task_id]).first
  end

  def create
    task = API::Task.includes(:framework).find(params[:task_id]).first
    submission = API::Submission.create(task_id: task.id)
    task.update(status: 'in_progress')

    ActiveStorage::Blob.create_after_upload!(
      io: params[:upload],
      filename: params[:upload].original_filename,
      content_type: params[:upload].content_type,
      metadata: { submission_id: submission.id }
    )

    redirect_to task_submission_path(task_id: task.id, id: submission.id)
  end

  def show
    @task = API::Task.includes(:framework).find(params[:task_id]).first
    @submission = API::Submission.includes(:entries).find(params[:id]).first

    render template_for_submission(@submission)
  end

  private

  def template_for_submission(submission)
    case submission.status
    when 'pending', 'processing' then :processing
    when 'in_review' then :in_review
    when 'completed' then :completed
    end
  end

  def handle_file_extension_validation
    redirect_to(
      new_task_submission_path(task_id: params[:task_id]),
      flash: { alert: 'Uploaded file must be in Microsoft Excel format (either .xlsx or .xls)' }
    )
  end

  def handle_file_presence_validation
    redirect_to(
      new_task_submission_path(task_id: params[:task_id]),
      flash: { alert: 'Please select a file' }
    )
  end

  def acceptable_file_extension?
    extension = File.extname(params[:upload].original_filename).downcase[1..-1]
    %w[xlsx xls].include?(extension)
  end

  def validate_file_presence_and_content_type
    handle_file_presence_validation && return if params[:upload].nil?

    handle_file_extension_validation unless acceptable_file_extension?
  end
end
