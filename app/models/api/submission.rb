module API
  class Submission < Base
    has_many :entries, class_name: 'SubmissionEntry'
    has_many :files, class_name: 'SubmissionFile'
  end
end
