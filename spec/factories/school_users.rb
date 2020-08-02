FactoryBot.define do
  factory :school_user do
    association :user, factory: [:user]
    association :school, factory: [:school]
    email { Faker::Internet.unique.email }
    invited_school_building_id { 1 }
    name_at_school { Faker::Name.unique.name[0..10] }
    start_at { 1.day.ago }
    end_at { 1.year.since }
    activated {  true }
  end
end
