class Validator
  def initialize(submission_entries:)
    @submission_entries = submission_entries
  end

  def status
    if validated?
      'validated'
    elsif errored?
      'errored'
    end
  end

  def errors
    return unless errored?

    @submission_entries.map(&:validation_errors).compact.flatten
  end

  private

  def validated?
    @submission_entries.map(&:status).all? { |status| status == 'validated' }
  end

  def errored?
    @submission_entries.map(&:status).any? { |status| status == 'errored' }
  end
end
