class SubmissionsController < ApplicationController
  before_action :validate_file_presence_and_content_type, only: [:create]

  def new
    @task = API::Task.includes(:framework).find(params[:task_id]).first
  end

  def create
    task = API::Task.includes(:framework).find(params[:task_id]).first

    submission = upload_file_submission(task, params[:upload])

    redirect_to task_submission_path(task_id: task.id, id: submission.id, correction: params[:correction])
  end

  def show
    @task = API::Task.includes(:framework).find(params[:task_id]).first
    @submission = API::Submission.includes(:files).find(params[:id]).first
    @file = @submission.files&.first

    render template_for_submission(@submission), status: status_for_submission(@submission)
  end

  def download
    submission = API::Submission.find(params[:id]).first

    submission_file = s3_client.get_object(bucket: ENV['AWS_S3_BUCKET'], key: submission.file_key)
    send_data submission_file.body.read, filename: submission.filename
  end

  private

  def upload_file_submission(task, upload)
    submission = API::Submission.create(
      task_id: task.id,
      purchase_order_number: params[:purchase_order_number],
      correction: params[:correction]
    )
    submission_file = API::SubmissionFile.create(submission_id: submission.id)

    blob = ActiveStorage::Blob.create_after_upload!(
      io: upload,
      filename: upload.original_filename,
      content_type: upload.content_type,
      metadata: { submission_id: submission.id, submission_file_id: submission_file.id }
    )

    # The file_id has to be included in the blob's attributes so that the
    # JSONAPI::Consumer::Resource correctly routes and assigns the blob to the
    # submission file
    blob_attributes = blob
                      .attributes
                      .slice('key', 'filename', 'content_type', 'byte_size', 'checksum')
                      .merge(file_id: submission_file.id)

    API::SubmissionFileBlob.create(blob_attributes)
    if correction?
      task.update(status: 'correcting')
    else
      task.update(status: 'in_progress')
    end

    submission
  end

  def template_for_submission(submission)
    case (status = submission.status)
    when 'pending' then 'processing'
    when 'management_charge_calculation_failed' then 'errors/internal_server_error'
    else status
    end
  end

  def status_for_submission(submission)
    case submission.status
    when 'management_charge_calculation_failed' then :internal_server_error
    else :ok
    end
  end

  def handle_file_extension_validation
    redirect_to(
      new_task_submission_path(task_id: params[:task_id], correction: params[:correction]),
      flash: { alert: 'Uploaded file must be in Microsoft Excel format (either .xlsx or .xls)' }
    )
  end

  def handle_file_presence_validation
    redirect_to(
      new_task_submission_path(task_id: params[:task_id], correction: params[:correction]),
      flash: { alert: 'Please select a file' }
    )
  end

  def acceptable_file_extension?
    extension = File.extname(params[:upload].original_filename).downcase[1..]
    %w[xlsx xls].include?(extension)
  end

  def validate_file_presence_and_content_type
    handle_file_presence_validation && return if params[:upload].nil?

    handle_file_extension_validation unless acceptable_file_extension?
  end

  def s3_client
    @s3_client ||= Aws::S3::Client.new(region: ENV['AWS_S3_REGION'])
  end
end
