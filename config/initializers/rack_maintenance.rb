Rails.application.config.middleware.use Rack::Maintenance,
  :file => Rails.root.join('public', 'maintenance.html'),
  :env  => 'MAINTENANCE' if ENV['MAINTENANCE']