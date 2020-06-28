# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { Faker::Book.unique.genre[0..9] }
    association :school, factory: [:school]
  end
end
