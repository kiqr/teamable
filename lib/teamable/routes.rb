# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper
      def teamable(team_label, options = {}, &block)
        options[:path] ||= team_label.to_s

        teamable_scope options do
          teamable_accounts(options)
          yield block if block_given?
        end
      end

      protected

      def teamable_scope(options, &block)
        scope options[:path], module: "teamable", &block
      end

      def teamable_accounts(_options)
        resource :account, only: %i[index], path: "" do
          get :setup, to: "setup#new"
          post :setup, to: "setup#create"
        end
      end
    end
  end
end
