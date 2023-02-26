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
end

group :development, :test, :rake do
  gem "bundler"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "foreman"
  gem "rb-readline"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "standard", "~> 1.2"
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "database_cleaner-active_record"
  gem "database_cleaner-redis"
  gem "factory_bot"
  gem "mocha", "~> 1.2", ">= 1.2.1"
  gem "rack-test"
  gem "rspec-rails", "~> 6.0.0"
  gem "shoulda-matchers", "~> 5.0"
  gem "webmock", "~> 3.5.0"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
