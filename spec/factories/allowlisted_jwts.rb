# frozen_string_literal: true

FactoryBot.define do
  factory :allowlisted_jwt do
    user { nil }
    jti { 'MyString' }
    aud { 'MyString' }
    exp { '2024-08-09 06:22:30' }
  end
end
