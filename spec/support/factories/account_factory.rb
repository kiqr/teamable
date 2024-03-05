# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { Faker::Company.unique.name }
  end
end
