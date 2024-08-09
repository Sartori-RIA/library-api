# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'bootsnap', require: false
gem 'cancancan'
gem 'devise', '~> 4.9'
gem 'devise-argon2', '~> 2.0'
gem 'devise-jwt', '~> 0.12.1'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem "searchkick"
gem "sidekiq", "~> 7.3"
gem "opensearch-ruby" # select one
gem 'redis', '~> 5.2'
# gem "rack-cors"

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
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
