# frozen_string_literal: true

module Teamable
  module Models
    module Account
      extend ActiveSupport::Concern
      include PublicUid::ModelConcern

      included do
        has_many :members
        has_many :users, through: :members

        validates :name, presence: true, length: { minimum: 4, maximum: 255 }
      end
    end
  end
end
