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
          redirect_to setup_personal_account_path
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

      private

      # Load current account from Account model and store it
      # in the Teamable::Current singleton.
      def load_current_account
        Teamable::Current.account ||= account_from_params || account_from_personal_account || nil
      end

      # Try to load current account using session[:teamable_account_id]
      def account_from_params
        return if params[:account_id].blank?

        current_user.accounts.find_puid(params[:account_id])
      end

      # Try to load current account using current_user.personal_account
      def account_from_personal_account
        return unless defined?(current_user)

        current_user.personal_account
      end

      # Check if the current controller is a TeamableController
      def teamable_controller?
        is_a?(::TeamableController)
      end
    end
  end
end
