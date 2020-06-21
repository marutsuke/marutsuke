# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text 'testtesttesttesttesttesttesttest'
    image { Faker::File.file_name }
    association :answer, factory: [:answer]
    association :teacher, factory: [:teacher]
  end
end
