module API
  class SubmissionFile < Base
    has_many :submission_entries

    belongs_to :submission

    def self.table_name
      'files'
    end
  end
end
