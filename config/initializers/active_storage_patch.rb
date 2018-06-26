Rails.application.config.after_initialize do
  # Patch for ActiveStorage::Service to support sending user-defined metadata to AWS S3
  ActiveStorage::Service.class_eval do
    # Upload the +io+ to the +key+ specified. If a +checksum+ is provided, the service will
    # ensure a match when the upload has completed or raise an ActiveStorage::IntegrityError.
    def upload(_key, _io, checksum: nil, metadata: nil)
      raise NotImplementedError
    end
  end

  # Patch for ActiveStorage::Blob to support sending user-defined metadata to AWS S3
  ActiveStorage::Blob.class_eval do
    class << self
      def build_after_upload(io:, filename:, content_type: nil, metadata: nil, identify: true)
        new.tap do |blob|
          blob.filename     = filename
          blob.content_type = content_type
          blob.metadata     = metadata

          blob.upload(io, identify: identify, metadata: metadata)
        end
      end
    end

    def upload(io, identify: true, metadata: nil)
      self.checksum     = compute_checksum_in_chunks(io)
      self.content_type = extract_content_type(io) if content_type.nil? || identify
      self.byte_size    = io.size
      self.identified   = true

      service.upload(key, io, checksum: checksum, metadata: metadata)
    end
  end
end
