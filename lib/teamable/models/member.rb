# frozen_string_literal: true

module Teamable
  module Models
    module Member
      extend ActiveSupport::Concern

      included do
        belongs_to :user
        belongs_to :account

        before_validation :set_owner_default_role, on: :create
        before_validation :find_user_from_invitee_email, on: :create
        validate :validate_membership_uniqueness, if: :user_id_changed?
        validates :role, presence: true
        validates :invitee_email, "valid_email_2/email": { mx: true }, allow_blank: true
        validates_inclusion_of :role, in: proc { ::Member::AVAILABLE_ROLES }
      end

      # Temporary store an invitee's email for validation.
      attr_accessor :invitee_email

      def role_name
        role.capitalize
      end

      def role?(str)
        role.include? str
      end

      private

      # Search for a user by invitee email and check if
      # it exists in the database and set it as user.
      def find_user_from_invitee_email
        return if invitee_email.nil?

        self.user = ::User.find_by(email: invitee_email)
        errors.add(:invitee_email, "is not a registered user") if user.nil?
      end

      def validate_membership_uniqueness
        return unless ::Member.where(account: account, user: user).first

        errors.add(:invitee_email, "is already a member")
      end

      def set_owner_default_role
        self.role = ::Member::FIRST_USER_ROLE if role.nil?
      end
    end
  end
end
