# frozen_string_literal: true

require "active_support/concern"

module Teamable
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        rescue_from Teamable::MissingAccountError do
          redirect_to setup_account_path
        end
      end

      # Method references in Teamable::AccountsController#switch to redirect a user
      # after they've switched to another account. You can override it in your
      # ApplicationController to provide a custom url.
      def after_account_switched_path
        root_path
      end

      # Raise Teamable::MissingAccountError unless account_selected? is true.
      def authenticate_account!
        return if teamable_controller?

        raise Teamable::MissingAccountError unless account_selected?
      end

      # Check if the current controller is a TeamableController
      def teamable_controller?
        is_a?(::TeamableController)
      end

      # Access current team.
      def current_account
        @current_account ||= nil
      end

      # Check if a team has been selected
      def account_selected?
        !!current_account
      end
    end
  end
end
