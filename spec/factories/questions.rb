# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    text { 'testtesttesttesttesttesttesttest' }
    image { Faker::File.file_name }
    display_order  { 1 }
    association :lesson, factory: [:lesson]
  end
end
