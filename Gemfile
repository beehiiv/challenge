# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", ">= 1.4.4", require: false
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "rails", "~> 6.1"

group :development, :test do
  gem "debug"
  gem "guard-rspec", require: false
end

group :development, :test, :rake do
  gem "brakeman"
  gem "bundler"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "foreman"
  gem "rb-readline"
  gem "rspec-rails", "~> 6.0.0"
  gem "shoulda-matchers", "~> 5.0"
  gem "standard", "~> 1.2"
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "bundler-audit"
  gem "database_cleaner-active_record"
  gem "database_cleaner-redis"
  gem "mocha", "~> 1.2", ">= 1.2.1"
  gem "rack-test"
  gem "webmock", "~> 3.5.0"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
