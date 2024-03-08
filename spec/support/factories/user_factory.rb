# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "#{Faker::Internet.unique.user_name}@mail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    trait :with_account do
      after :create do |user|
        user.accounts << FactoryBot.build(:account)
        personal_account = FactoryBot.build(:account, :personal)
        user.personal_account = personal_account
        user.accounts << personal_account
        user.save
      end
    end
  end
end
