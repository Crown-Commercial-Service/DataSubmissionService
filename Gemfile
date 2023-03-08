source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.8.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0', '>= 6.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11', '>= 2.11.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'aws-sdk-s3'
gem 'haml-rails', '>= 2.1.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Authentication
gem 'omniauth'
gem 'omniauth-auth0', '~> 2.0.0'
gem 'omniauth-rails_csrf_protection', '>= 1.0.1'

# API requests
gem 'httparty', '>= 0.21.0'
gem 'jsonapi-consumer', '~> 1.0', '>= 1.0.1'

# Pagination
gem 'kaminari', '>= 1.2.2'

# Cookie handling
gem 'js_cookie_rails', '~> 2.2', '>= 2.2.0'

gem 'jquery-rails', '>= 4.5.1'

# Exception tracking
gem 'rollbar'

# Logging
gem 'lograge', '>= 0.12.0'

gem 'skylight'

# Auth0 client for user setup scripts
gem 'auth0', require: false

# Locking above vulnerable version https://nvd.nist.gov/vuln/detail/CVE-2019-5477
gem 'nokogiri', '>= 1.13.9'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '>= 2.8.1'
  gem 'factory_bot_rails', '>= 6.2.0'
  gem 'pry-rails'
  gem 'rspec-rails', '>= 5.1.2'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.7.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 3.38.0', require: false
  gem 'climate_control'
  gem 'database_cleaner'
  gem 'launchy', '>= 2.4.3'
  gem 'poltergeist', '>= 1.18.1'
  gem 'webmock', '~> 3.12.2'
  gem 'simplecov', '0.17', require: false # SimpleCov 0.18+ not yet supported by Codeclimate
  gem 'orderly', '>= 0.1.1'
end
