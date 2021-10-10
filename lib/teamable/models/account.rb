# frozen_string_literal: true

module Teamable
  module Models
    module Account
      extend ActiveSupport::Concern

      included do
        has_many :members
        has_many :users, through: :members
        belongs_to :owner, class_name: "User"

        validates :name, presence: true
        validates :billing_email, "valid_email_2/email": { mx: true }, presence: true
      end
    end
  end
end
