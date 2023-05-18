Rails.application.config.session_store :cookie_store,
  :key => '_data_submission_service_session', 
  :expire_after => 20.minutes