# frozen_string_literal: true

require "active_support/concern"

module Teamable
  module Controllers
    module CurrentAccountHelper
      extend ActiveSupport::Concern

      included do
        before_action :load_current_account

        if respond_to?(:helper_method)
          helpers = %w[current_account account_selected?]
          helper_method(*helpers)
        end

        rescue_from Teamable::MissingAccountError do
          redirect_to setup_account_path
        end
      end

      # Raise Teamable::MissingAccountError unless account_selected? is true.
      def authenticate_account!
        return unless user_signed_in?
        return if teamable_controller?

        raise Teamable::MissingAccountError unless account_selected?
      end

      # Access current team.
      def current_account
        @current_account ||= Teamable::Current.account
      end

      # Check if a team has been selected
      def account_selected?
        !!current_account
      end

      # Store an account id in a session variable.
      # Warning: this does not validate that the current_user
      # actually is a member of the specified account.
      def update_teamable_session_id!(account_id)
        session[:teamable_account_id] = account_id
      end

      private

      # Load current account from Account model and store it
      # in the Teamable::Current singleton.
      def load_current_account
        return unless user_signed_in?

        Teamable::Current.account ||= account_from_session || fallback_account || nil
      end

      # Try to load current account using session[:teamable_account_id]
      def account_from_session
        return if session[:teamable_account_id].blank?

        current_user.accounts.find_by(id: session[:teamable_account_id])
      end

      # Finds last joined account if the user have any associated accounts.
      def fallback_account
        memberships = current_user.members
        return nil if memberships.length.zero?

        memberships.last.account # Return last joined account.
      end

      # Check if the current controller is a TeamableController
      def teamable_controller?
        is_a?(::TeamableController)
      end
    end
  end
end
