FactoryBot.define do
  factory :school_user do
    association :user, factory: [:user]
    association :school, factory: [:school]
    start_at { 1.day.ago }
    end_at { 1.year.since }
    activated {  true }
  end
end
