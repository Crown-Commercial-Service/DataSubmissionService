module SubmissionsHelper
  def potentially_truncated_errors(submission)
    submission.sheet_errors.any? { |_sheet_key, errors| errors.size >= 10 }
  end

  def submission_completed_text(task)
    [
      task.description,
      "management information for #{task.framework.short_name} #{task.framework.name} submitted to CCS"
    ].compact.join(' ').upcase_first
  end
end
