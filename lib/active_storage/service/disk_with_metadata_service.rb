require 'active_storage/service/disk_service'

class ActiveStorage::Service::DiskWithMetadataService < ActiveStorage::Service::DiskService
  def upload(key, io, checksum: nil, metadata: nil)
    instrument :upload, key: key, checksum: checksum do
      IO.copy_stream(io, make_path_for(key))
      ensure_integrity_of(key, checksum) if checksum
    end
  end
end
