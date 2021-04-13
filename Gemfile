source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'aws-sdk-s3'
gem 'haml-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Authentication
gem 'omniauth'
gem 'omniauth-auth0', '~> 2.0.0'
gem 'omniauth-rails_csrf_protection'

# API requests
gem 'httparty'
gem 'jsonapi-consumer', '~> 1.0'

# Pagination
gem 'kaminari'

# Exception tracking
gem 'rollbar'

# Logging
gem 'lograge'
gem 'skylight'

# Auth0 client for user setup scripts
gem 'auth0', require: false

# Locking above vulnerable version https://nvd.nist.gov/vuln/detail/CVE-2019-5477
gem 'nokogiri', '>= 1.10.4'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', require: false
  gem 'climate_control'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'poltergeist'
  gem 'webmock'
  gem 'simplecov', '0.17', require: false # SimpleCov 0.18+ not yet supported by Codeclimate
end
