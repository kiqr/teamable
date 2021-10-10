# frozen_string_literal: true

module Teamable
  module Models
    module Account
      extend ActiveSupport::Concern

      included do
        has_many :members
        has_many :users, through: :members

        validates :name, presence: true
        validates :billing_email, presence: true, uniqueness: true
        validates_format_of :billing_email, with: Teamable.config.email_regexp
      end
    end
  end
end
