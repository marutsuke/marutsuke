# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.unique.paragraph[0..9] }
    association :school, factory: [:school]
  end
end
