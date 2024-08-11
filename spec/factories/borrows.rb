FactoryBot.define do
  factory :borrow do
    book
    user
    end_date { 2.weeks.from_now }
    returned { false }
    expired { false }
    trait :as_expired do
      created_at { 1.month.ago }
    end
  end
end
