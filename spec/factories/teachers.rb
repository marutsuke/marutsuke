FactoryBot.define do
  factory :teacher do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password 'password'
    start_at 1.day.ago
    end_at 1.year.since
    activated false
    association :school, factory: [:school]
  end
end
