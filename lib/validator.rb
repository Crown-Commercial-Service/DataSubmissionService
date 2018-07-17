class Validator
  def initialize(submission:)
    @submission = submission
    @submission_entries = submission.entries
  end

  def status
    if levy_completed?
      'levy_completed'
    elsif validated?
      'validated'
    elsif errored?
      'errored'
    end
  end

  def errors
    return unless errored?

    @submission_entries.map(&:validation_errors).compact.flatten
  end

  def pending?
    @submission_entries.map(&:status).any? { |status| status == 'pending' }
  end

  private

  def validated?
    @submission_entries.map(&:status).all? { |status| status == 'validated' }
  end

  def errored?
    @submission_entries.map(&:status).any? { |status| status == 'errored' }
  end

  def submission_completed?
    @submission.status == 'completed'
  end

  def levy_completed?
    validated? && submission_completed?
  end
end
