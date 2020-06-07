# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { Faker::Book.genre }
    association :school, factory: [:school]
  end
end
