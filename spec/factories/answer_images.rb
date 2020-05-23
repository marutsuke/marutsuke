# frozen_string_literal: true

FactoryBot.define do
  factory :answer_image do
    image { Faker::File.file_name }
    association :answer, factory: [:answer]
  end
end
