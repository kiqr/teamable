# frozen_string_literal: true

require "teamable/version"
require "teamable/engine"

require "dry-configurable"

# Enable role based multi-user accounts (teams/organizations) in Rails.
module Teamable
  extend Dry::Configurable

  module Models
    autoload :Account, "teamable/models/account"
    autoload :Member, "teamable/models/member"
    autoload :User, "teamable/models/user"
  end

  # Email regex used to validate email formats. It simply asserts that
  # one (and only one) @ exists in the given string. This is mainly
  # to give user feedback and not to assert the e-mail validity.
  setting :email_regexp, /\A[^@\s]+@[^@\s]+\z/
end
