class UploadsController < ApplicationController
  before_action :validate_file_presence_and_content_type, only: [:create]

  def create
    blob = ActiveStorage::Blob.create_after_upload!(
      io: params[:upload],
      filename: params[:upload].original_filename,
      content_type: params[:upload].content_type,
      # TODO: to be changed to a dynamic submission_id
      metadata: { submission_id: 'f57f4344-0c6c-4a84-9fbc-76ea71b57b29' }
    )
    redirect_to tasks_path, flash: { message: "#{blob.filename} file upload successful!" }
  end

  private

  def handle_content_type_validation
    flash.now[:alert] = 'File content_type must be an xlsx or xlx'
    render 'tasks/index'
  end

  def handle_file_presence_validation
    flash.now[:alert] = 'Please select a file'
    render 'tasks/index'
  end

  def content_type_valid?
    excel_mime_types.include? params[:upload].content_type
  end

  def excel_mime_types
    %w[application/vnd.ms-excel
       application/vnd.openxmlformats-officedocument.spreadsheetml.sheet]
  end

  def validate_file_presence_and_content_type
    handle_file_presence_validation && return if params[:upload].nil?

    handle_content_type_validation unless content_type_valid?
  end
end
