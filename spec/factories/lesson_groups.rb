# frozen_string_literal: true

FactoryBot.define do
  factory :lesson_group do
    name { Faker::Name.unique.name[0..10] }
    association :school_building, factory: [:school_building]
    min_school_grade { 4 }
    max_school_grade { nil }
    free_attend { false }
  end
end
