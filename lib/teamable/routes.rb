# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper
      def teamable(teamable_path = nil, options = {}, &block)
        options = default_options(teamable_path, options)

        resource :personal_account, only: %i[], path: "onboarding" do
          get :setup, controller: options[:setup_controller], action: "new"
          post :setup, controller: options[:setup_controller], action: "create"
        end

        teamable_settings(options)

        scope "(/#{options[:path]}/:account_id)", account_id: %r{[^/]+} do
          yield block if block
        end
      end

      private

      def teamable_settings(options)
        resource :account, only: %i[new create], controller: options[:accounts_controller], path: options[:path].to_s do
          patch ":account_id/switch", action: "switch", as: :switch
        end
      end

      def default_options(teamable_path, options)
        options[:path] = teamable_path || "team"
        options[:setup_controller] ||= "teamable/setup"
        options[:accounts_controller] ||= "teamable/accounts"
        options
      end
    end
  end
end
