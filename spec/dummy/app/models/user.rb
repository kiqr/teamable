# frozen_string_literal: true

class User < ApplicationRecord
  include Teamable::Models::User
  authenticatable
end
