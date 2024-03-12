# frozen_string_literal: true

source "https://rubygems.org"

gemspec

RAILS_VERSION = ENV.fetch("RAILS_VERSION", "~> 7.1.0")

if RAILS_VERSION == "master"
  gem "rails", github: "rails/rails", require: false
else
  gem "rails", RAILS_VERSION, require: false
end

gem "codecov", require: false
gem "devise", "~> 4.9"
gem "factory_bot_rails"
gem "faker"
gem "generator_spec"
gem "rails-controller-testing"
gem "rspec-rails"
gem "standard"
gem "shoulda-matchers", "~> 5.0"
gem "simplecov", require: false
gem "sqlite3"
