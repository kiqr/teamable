# frozen_string_literal: true

module Teamable
  module Models
    module Member
      extend ActiveSupport::Concern

      included do
        belongs_to :user
        belongs_to :account

        before_validation :set_owner_default_role, on: :create
        validates :role, presence: true
        validates_format_of :invitee_email, with: Teamable.config.email_regexp, allow_blank: true
        validates_inclusion_of :role, in: proc { ::Member::AVAILABLE_ROLES }
      end

      # Temporary store an invitee's email for validation.
      attr_accessor :invitee_email

      def role_name
        role.capitalize
      end

      def role?(input)
        role.include? input.to_s
      end

      private

      def set_owner_default_role
        self.role = ::Member::FIRST_USER_ROLE if role.nil?
      end
    end
  end
end
