# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'cancancan'
gem 'devise', '~> 4.9'
gem 'devise-argon2', '~> 2.0'
gem 'devise-i18n', '~> 1.12'
gem 'devise-jwt', '~> 0.12.1'
gem 'dotenv-rails'
gem 'opensearch-ruby' # select one
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'rails-i18n', '~> 7.0'
gem 'redis', '~> 5.2'
gem 'searchkick'
gem 'sidekiq', '~> 7.3'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'parallel_tests'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rubocop'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
end

group :test do
  gem 'database_cleaner'
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'simplecov-console'
end

gem "apipie-rails", "~> 1.4"

gem "pagy", "~> 9.0"
