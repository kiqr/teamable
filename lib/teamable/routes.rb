# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper
      def teamable(team_label, options = {}, &block)
        options[:path] ||= team_label.to_s
        options[:setup_controller] ||= "teamable/setup"
        options[:accounts_controller] ||= "teamable/accounts"

        teamable_scope options do
          teamable_accounts(options)
          yield block if block_given?
        end
      end

      protected

      def teamable_scope(options, &)
        scope(options[:path], &)
      end

      def teamable_accounts(options)
        resource :account, only: %i[new create], controller: options[:accounts_controller], path: "" do
          get :setup, controller: options[:setup_controller], action: "new"
          post :setup, controller: options[:setup_controller], action: "create"
          patch ":id/switch", action: "switch", as: :switch
        end
      end
    end
  end
end
