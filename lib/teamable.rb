# frozen_string_literal: true

require "teamable/version"
require "teamable/engine"

# Enable role based multi-user accounts (teams/organizations) in Rails.
module Teamable
  module Models
    autoload :Account, "teamable/models/account"
    autoload :Member, "teamable/models/member"
    autoload :User, "teamable/models/user"
  end
end
