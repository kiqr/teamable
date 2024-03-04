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

# Load support helpers
Dir[Teamable::Engine.root.join("spec/support/**/*.rb")].each { |f| require f }

migrate_path = File.expand_path("dummy/db/migrate/", __dir__)

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)
ActiveRecord::MigrationContext.new(migrate_path).migrate

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.use_transactional_fixtures = true
  config.order = :random

  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :request
end

RSpec.shared_context "with api request global before and after hooks" do
  before do
    Warden.test_mode!
  end

  after do
    Warden.test_reset!
  end
end

RSpec.shared_context "with api request authentication helper methods" do
  def sign_in(user)
    login_as(user, scope: :user)
  end

  def sign_out
    logout(:user)
  end
end

# Configure shoulda
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
