source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1', '>= 7.1.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 6.4', '>= 6.4.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0', '>= 6.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.12', '>= 2.12.0'

gem 'jwt', '~> 2.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Alpine and Windows do not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby ruby]

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'aws-sdk-s3'
gem 'haml-rails', '>= 2.1.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Authentication
gem 'omniauth', '>= 2.1.2'
gem 'omniauth-auth0', '~> 2.1.0'
gem 'omniauth-rails_csrf_protection', '>= 1.0.2'

# API requests
gem 'httparty', '>= 0.21.0'
gem 'jsonapi-consumer', git: 'https://github.com/jsmestad/jsonapi-consumer.git', ref: '7d9721e'

# Pagination
gem 'kaminari', '>= 1.2.2'

# Cookie handling
gem 'js_cookie_rails', '~> 2.2', '>= 2.2.0'

gem 'jquery-rails', '>= 4.6.0'

# Exception tracking
gem 'rollbar'

# Logging
gem 'lograge', '>= 0.13.0'

gem 'sprockets-rails', '~> 3.5', '>= 3.5.0'

# To enable app maintenance mode
gem 'rack-maintenance', '~> 3.0'

# Auth0 client for user setup scripts
gem 'auth0', '~> 4.17', require: false

# Locking above vulnerable version https://nvd.nist.gov/vuln/detail/CVE-2019-5477
gem 'nokogiri', '>= 1.16.5'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '>= 3.1.0'
  gem 'factory_bot_rails', '>= 6.3.0'
  gem 'pry-rails'
  gem 'rspec-rails', '>= 6.1.2'
  gem 'rubocop', '>= 1.66.0', require: false
  gem 'rubocop-rails', '>= 2.24.0', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.2.1'
  gem 'listen', '~> 3.5', '>= 3.5.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 3.40.0', require: false
  gem 'climate_control'
  gem 'database_cleaner', '>= 2.0.2'
  # gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'poltergeist', '>= 1.18.1'
  gem 'webmock', '~> 3.14.0'
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'orderly', '>= 0.1.1'
end
