# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { Faker::Company.unique.name }
    billing_email { "#{Faker::Internet.unique.user_name}.team@mail.com" }
  end
end
