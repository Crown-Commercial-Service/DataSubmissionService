class UploadsController < ApplicationController
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
end
