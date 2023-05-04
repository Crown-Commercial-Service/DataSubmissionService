Rails.application.reloader.to_prepare do
  VcapParser.load_service_environment_variables!
end
