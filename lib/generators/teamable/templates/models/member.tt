# frozen_string_literal: true

class Member < ApplicationRecord
  include Teamable::Models::Member

  AVAILABLE_ROLES = %w[owner admin member].freeze
  FIRST_USER_ROLE = "owner" # Default role for the user who created the account.
end
