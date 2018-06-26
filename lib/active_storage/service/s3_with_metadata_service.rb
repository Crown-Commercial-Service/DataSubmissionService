require 'active_storage/service/s3_service'

class ActiveStorage::Service::S3WithMetadataService < ActiveStorage::Service::S3Service
  def upload(key, io, checksum: nil, metadata: nil)
    instrument :upload, key: key, checksum: checksum do
      object_for(key).put(upload_options.merge(body: io, content_md5: checksum, metadata: metadata))
    rescue Aws::S3::Errors::BadDigest
      raise ActiveStorage::IntegrityError
    end
  end
end
