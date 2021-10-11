# frozen_string_literal: true

require "active_support/concern"

module Teamable
  module Controllers
    module UrlHelpers
      extend ActiveSupport::Concern

      # Method references in Teamable::AccountsController#switch to redirect a user
      # after they've switched to another account. You can override it in your
      # ApplicationController to provide a custom url.
      def after_account_switched_path
        root_path
      end
    end
  end
end
