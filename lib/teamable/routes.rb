# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper
      def teamable(team_label, options = {}, &block)
        options[:path] ||= team_label.to_s
        options[:setup_controller] ||= "teamable/setup"
        options[:accounts_controller] ||= "teamable/accounts"

        resource :personal_account, only: %i[], path: "onboarding" do
          get :setup, controller: options[:setup_controller], action: "new"
          post :setup, controller: options[:setup_controller], action: "create"
        end

        teamable_settings(options)

        scope "(/#{options[:path]}/:account_id)", account: %r{[^/]+} do
          yield block if block_given?
        end
      end

      private

      def teamable_settings(options)
        resource :account, only: %i[new create], controller: options[:accounts_controller], path: options[:path].to_s do
          patch ":account_id/switch", action: "switch", as: :switch
        end
      end
    end
  end
end
