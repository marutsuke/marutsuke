FactoryBot.define do
  factory :school_user do
    association :user, factory: [:user]
    association :school, factory: [:school]
    nickname { Faker::Name.unique.name[0..10] }
    start_at { 1.day.ago }
    end_at { 1.year.since }
    activated {  true }
  end
end
