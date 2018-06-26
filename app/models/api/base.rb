module API
  class Base < JSONAPI::Consumer::Resource
    self.site = ENV['API_ROOT'] + 'v1/'
  end
end
