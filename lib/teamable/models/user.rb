# frozen_string_literal: true

module Teamable
  module Models
    module User
      extend ActiveSupport::Concern

      included do
        has_many :members
        has_many :accounts, through: :members

        has_many   :teams, -> { where(personal_account: false) }, through: :account_users, source: :account
        belongs_to :personal_account, class_name: "Account"
      end
    end
  end
end
