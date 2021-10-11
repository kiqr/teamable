# frozen_string_literal: true

module Teamable
  # Global class that holds the current user's selected team.
  class Current < ActiveSupport::CurrentAttributes
    attribute :account
  end
end
