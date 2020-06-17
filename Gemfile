source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '>= 3.12.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# The Numerical N-dimensional Array class for fast processing and easy manipulation of multi-dimensional numerical data, similar to numpy.ndaray
# https://github.com/ruby-numo/numo-narray
gem 'numo-narray'

# The high performance scoring engine for ML models
# https://github.com/ankane/onnxruntime
gem 'onnxruntime', '0.3.1'

# Ruby-FFI is a gem for programmatically loading dynamically-linked native libraries, binding functions within them, and calling those functions from Ruby code.
# https://github.com/ffi/ffi
gem 'ffi', '1.12.2'

# Bootstrap 4 ruby gem for Ruby on Rails (Sprockets) and Hanami (formerly Lotus).
# https://github.com/twbs/bootstrap-rubygem
gem 'bootstrap'

# jQuery for Rails
# https://github.com/rails/jquery-rails
gem 'jquery-rails'

# Centralization of locale data collection
# https://github.com/svenfuchs/rails-i18n
gem 'rails-i18n'

# Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser. Among Nokogiri's many features is the ability to search documents via XPath or CSS3 selectors.
# https://nokogiri.org/
gem 'nokogiri'

# This gem provides a simple and extremely flexible way to upload files from Ruby applications.
# https://github.com/carrierwaveuploader/carrierwave
gem 'carrierwave'

# Complete geocoding solution for Ruby.
# https://github.com/alexreisner/geocoder
gem 'geocoder'

# Devise is a flexible authentication solution for Rails based on Warden.
# https://github.com/heartcombo/devise
gem 'devise'

# This gem contains the Twitter strategy for OmniAuth
# https://github.com/arunagw/omniauth-twitter
gem 'omniauth-twitter'

# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for modern web app frameworks and ORMs
# https://github.com/kaminari/kaminari
gem 'kaminari'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [ :mri, :mingw, :x64_mingw ]

  # rspec-rails brings the RSpec testing framework to Ruby on Rails as a drop-in alternative to its default testing framework, Minitest.
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails'

  # factory_bot is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances,
  # attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.
  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails'

  # This gem brings back assigns to your controller tests as well as assert_template to both controller and integration tests
  # https://github.com/rails/rails-controller-testing
  gem 'rails-controller-testing'

  # RackSessionAccess provides rack middleware for 'rack.session' environment management.
  # https://github.com/railsware/rack_session_access
  gem 'rack_session_access'

  # Database Cleaner is a set of gems containing strategies for cleaning your database in Ruby.
  # https://github.com/DatabaseCleaner/database_cleaner
  gem 'database_cleaner'

  # rails-flog provides feature that formats parameters Hash and SQL in Rails log file.
  # https://github.com/pinzolo/rails-flog
  gem 'rails-flog', require: 'flog'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter.
  # https://github.com/rubocop-hq/rubocop
  gem 'rubocop', require: false

  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  # https://github.com/rubocop-hq/rubocop-rails
  gem 'rubocop-rails', require: false

  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug.
  # https://github.com/deivid-rodriguez/pry-byebug
  gem 'pry-byebug'

  # Add a comment summarizing the current schema
  # https://github.com/ctran/annotate_models
  gem 'annotate'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [ :mingw, :mswin, :x64_mingw, :jruby ]
