module API
  class SubmissionFile < Base
    has_many :submission_entries

    belongs_to :submission
  end
end
