require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs_options: ['--load-images=false'])
end

Capybara.javascript_driver = :poltergeist
Capybara.ignore_hidden_elements = true

module Capybara
  class Session
    def has_flash_message?(message)
      has_css?('div.flash', text: message)
    end
  end
end
