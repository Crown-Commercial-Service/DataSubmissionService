class UploadsController < ApplicationController
  def create
    blob = ActiveStorage::Blob.create_after_upload!(
      io: params[:upload],
      filename: params[:upload].original_filename,
      content_type: params[:upload].content_type
    )

    render json: { file_uri: url_for(blob) }
  end
end
