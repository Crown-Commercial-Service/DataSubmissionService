module SubmissionsHelper
  def potentially_truncated_errors(submission)
    submission.sheet_errors.any? { |_sheet_key, errors| errors.size >= 10 }
  end
end
