# frozen_string_literal: true

module Teamable
  module Models
    module Account
      extend ActiveSupport::Concern

      included do
        has_many :members
        has_many :users, through: :members

        validates :name, presence: true
      end
    end
  end
end
