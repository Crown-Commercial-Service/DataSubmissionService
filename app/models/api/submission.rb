module API
  class Submission < Base
    has_many :submission_files
    has_many :submission_entries
  end
end
