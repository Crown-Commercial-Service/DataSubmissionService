class Auditor
  include HTTParty
  base_uri "#{ENV['API_ROOT']}v1/events"

  def user_signed_in(user_id:)
    self.class.post('/user_signed_in', query: { user_id: user_id })
  end

  def user_signed_out(user_id:)
    self.class.post('/user_signed_out', query: { user_id: user_id })
  end

  def user_terminated(user_id:)
    self.class.post('/user_terminated', query: { user_id: user_id })
  end
end
