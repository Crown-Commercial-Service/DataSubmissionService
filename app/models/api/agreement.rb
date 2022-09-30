module API
  class Agreement < Base
    has_one :framework
    has_one :supplier
  end
end
