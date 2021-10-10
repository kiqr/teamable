# frozen_string_literal: true

module Teamable
  module Models
    module User
      extend ActiveSupport::Concern

      included do
        has_many :members
        has_many :accounts, through: :members
      end
    end
  end
end
