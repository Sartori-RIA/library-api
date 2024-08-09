# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'MyString' }
    author { 'MyString' }
    genre { 'MyString' }
    isbn { 'MyString' }
    total_copies { 1 }
  end
end
