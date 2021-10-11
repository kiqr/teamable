# frozen_string_literal: true

require "teamable/current"
require "teamable/routes"
require "teamable/version"

require "teamable/engine"

require "dry-configurable"

# Enable role based multi-user accounts (teams/organizations) in Rails.
module Teamable
  extend Dry::Configurable

  module Controllers
    autoload :CurrentAccountHelper, "teamable/controllers/current_account_helper"
    autoload :UrlHelpers, "teamable/controllers/url_helpers"
  end

  module Models
    autoload :Account, "teamable/models/account"
    autoload :Member, "teamable/models/member"
    autoload :User, "teamable/models/user"
  end

  autoload :MissingAccountError, "teamable/errors/missing_account_error"

  # The controller class that all Teamable controllers will inherit from.
  # Defaults to `ApplicationController`.
  setting :parent_controller, "ApplicationController"

  # Email regex used to validate email formats. It simply asserts that
  # one (and only one) @ exists in the given string. This is mainly
  # to give user feedback and not to assert the e-mail validity.
  setting :email_regexp, /\A[^@\s]+@[^@\s]+\z/
end
