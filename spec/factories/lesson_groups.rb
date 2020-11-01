# frozen_string_literal: true

FactoryBot.define do
  factory :lesson_group do
    name { Faker::Name.unique.name[0..10] }
    association :school_building, factory: [:school_building]
  end
end
