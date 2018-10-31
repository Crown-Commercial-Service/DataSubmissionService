module API
  class Framework < Base
    def safe_short_name
      short_name.gsub(/[^0-9A-Z]/i, '-')
    end
  end
end
