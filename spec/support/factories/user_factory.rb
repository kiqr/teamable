# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "#{Faker::Internet.unique.user_name}@mail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    trait :with_account do
      after :create do |user|
        user.accounts << FactoryBot.build(:account)
        user.save
      end
    end
  end
end
