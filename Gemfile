# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'haml', '~> 5'
gem 'bootstrap-sass', '~> 3.4'
gem 'devise', github: 'heartcombo/devise', ref: '0cd72a56f984a7ff089246f87a8b259120545edd'
gem 'bootstrap_form', '~> 2.5.0'
gem 'omniauth-github', '~> 2'
gem 'omniauth-rails_csrf_protection'
gem 'kramdown', '~> 2.3'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'font-awesome-sass', '~> 4.3.2'
gem 'rails-assets-clipboard', source: 'https://rails-assets.org'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'dalli', '~> 2.7.6'
gem 'sentry-raven', '~> 2.13'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'coveralls', require: false
  gem 'database_cleaner', '~> 1.7'
  gem 'webmock'
  gem 'rubocop', '~> 0.78.0'
  gem 'rubocop-rails', '~> 2.4'
  gem 'capybara-selenium'
  gem 'webdrivers', '~> 4.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "letter_opener", '~> 1.4.1'
  gem 'dotenv-rails', '~> 2.7'
  gem 'guard', '~> 2'
  gem 'guard-rspec', '~> 4'
  gem 'guard-livereload', '~> 2.5.2'
  gem 'rack-livereload', '~> 0.3.16'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
