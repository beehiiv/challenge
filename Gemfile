source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails", "~> 6.1"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  gem "debug"
end

group :development, :test, :rake do
  gem "bundler"
  gem "foreman"
  gem "rb-readline"
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
  gem "rack-test"
  gem "rspec-rails", "~> 4.0.1"
  gem "webmock", "~> 3.5.0"
  gem "mocha", "~> 1.2", ">= 1.2.1"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
