# frozen_string_literal: true

require "simplecov"
SimpleCov.start("rails")

if ENV["CODECOV"] == "true"
  require "codecov"
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

ENV["RAILS_ENV"] ||= "test"

# Rails dummy application.
require "dummy/application"
Rails.application.initialize!

require "rspec/rails"
require "authenticatable"

# Load support helpers
Dir[Teamable::Engine.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

migrate_path = File.expand_path("dummy/db/migrate/", __dir__)

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

if Rails.version.start_with?("6", "7")
  ActiveRecord::MigrationContext.new(migrate_path, ActiveRecord::SchemaMigration).migrate
elsif Rails.version.start_with? "5.2"
  ActiveRecord::MigrationContext.new(migrate_path).migrate
else
  ActiveRecord::Migrator.migrate(migrate_path)
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.use_transactional_fixtures = true
  config.order = :random
end
