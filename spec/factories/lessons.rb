# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    name { Faker::Book.genre[0..10] }
    start_at { 1.day.ago }
    end_at { 1.year.since }
    association :teacher, factory: [:teacher]
    association :school, factory: [:school]
    association :lesson_group, factory: [:lesson_group]

    trait(:going_to) { start_at { 1.hour.since } }
    trait(:doing) { name { '現在開催中' } }
    trait(:done) { end_at { 1.hour.ago } }
  end
end
