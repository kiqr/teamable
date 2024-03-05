# frozen_string_literal: true

require "rails/generators/base"
require "rails/generators/active_model"
require "rails/generators/active_record/migration"

module Teamable
  class InvalidUserModel < StandardError; end

  class InstallGenerator < Rails::Generators::Base
    include ActiveRecord::Generators::Migration
    source_root File.expand_path("templates", __dir__)

    def check_install_requirements
      return if user_model_exists?

      say "Teamable requires a User model to be present before you continue with the install", :red
      say "Learn more at: https://github.com/kiqr/teamable#getting-started", :red
      raise Teamable::InvalidUserModel, "Missing file: #{user_model_path}"
    end

    def inject_into_user_model
      inject_into_class user_model_path, "User" do
        "  include Teamable::Models::User\n"
      end
    end

    def generate_models
      template "models/account.tt", "app/models/account.rb"
      template "models/member.tt", "app/models/member.rb"
    end

    def generate_migrations
      migration_template "migrations/account.tt", "#{db_migrate_path}/teamable_create_accounts.rb"
      migration_template "migrations/member.tt", "#{db_migrate_path}/teamable_create_members.rb"
      migration_template "migrations/user.tt", "#{db_migrate_path}/teamable_add_personal_account_to_users.rb"
    end

    def add_route
      route 'teamable "account"'
    end

    private

    def user_model_exists?
      File.exist?(user_model_path)
    end

    def user_model_path
      File.join(destination_root, "app/models/user.rb")
    end
  end
end
