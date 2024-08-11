# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email" }
    name { Faker::Name.name }
    password { '123456' }
    role { User.roles.keys.sample }
  end
end
