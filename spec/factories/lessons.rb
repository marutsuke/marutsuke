# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    name { Faker::Book.genre }
    start_at 1.day.ago
    end_at 1.year.since
    association :teacher, factory: [:teacher]
    association :school, factory: [:school]
  end
end
