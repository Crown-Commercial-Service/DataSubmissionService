module API
  class SubmissionFile < Base
    has_many :submission_entries

    belongs_to :submission

    def self.resource_path
      'files'
    end
  end
end
