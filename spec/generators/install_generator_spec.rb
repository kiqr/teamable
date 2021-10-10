# frozen_string_literal: true

require "spec_helper"
require "generator_spec"

require "generators/teamable/install_generator"

# rubocop:disable RSpec/ExampleLength, Lint/AmbiguousBlockAssociation
module Teamable
  module Generators
    describe InstallGenerator, type: :generator do
      destination TMP_GENERATORS_DIR

      before do
        prepare_destination
        create_routes_file_helper
        create_dummy_user_helper
      end

      after do
        rm_rf TMP_GENERATORS_DIR
      end

      it "raises error if user model does not exist" do
        FileUtils.rm File.join(destination_root, "app/models/user.rb")
        expect { run_generator }.to raise_error(Teamable::InvalidUserModel)
      end

      it "injects concern into user model" do
        run_generator

        expect(destination_root).to have_structure {
          directory "app" do
            directory "models" do
              file "user.rb" do
                contains "include Teamable::Models::User"
              end
            end
          end
        }
      end

      it "generates models" do
        run_generator

        expect(destination_root).to have_structure {
          directory "app" do
            directory "models" do
              file "account.rb" do
                contains "include Teamable::Models::Account"
              end
              file "member.rb" do
                contains "include Teamable::Models::Member"
                contains "AVAILABLE_ROLES = "
                contains "FIRST_USER_ROLE = "
              end
            end
          end
        }
      end

      it "generates migrations" do
        run_generator

        expect(destination_root).to have_structure {
          directory "db" do
            directory "migrate" do
              migration "teamable_create_accounts" do
                contains "class TeamableCreateAccounts"
                contains "t.string :name, null: false"
                contains "t.string :billing_email, null: false"
              end
              migration "teamable_create_members" do
                contains "class TeamableCreateMembers"
                contains "t.references :user, foreign_key: { to_table: :users }"
                contains "t.references :account, foreign_key: { to_table: :accounts }"
                contains "t.string :role, nullable: false"
              end
            end
          end
        }
      end

      it "add routes to route.rb" do
        run_generator

        expect(destination_root).to have_structure {
          directory "config" do
            file "routes.rb" do
              contains 'teamable "account"'
            end
          end
        }
      end
    end
  end
end
# rubocop:enable RSpec/ExampleLength, Lint/AmbiguousBlockAssociation
