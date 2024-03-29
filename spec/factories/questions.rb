# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    text { 'testtesttesttesttesttesttesttest' }
    image { Faker::File.file_name }
    display_order  { Faker::Number.between(from: 1, to: 1000) }
    publish { true }
    association :lesson, factory: [:lesson]
  end
  trait(:published) { publish { true } }
  trait(:unpublish) { publish { false } }
end
