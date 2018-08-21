module API
  class SubmissionFileBlob < Base
    belongs_to :file, class_name: 'SubmissionFile'

    def self.resource_path
      'blobs'
    end
  end
end
