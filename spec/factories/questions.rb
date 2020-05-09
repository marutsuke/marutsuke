# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Book.genre }
    text 'testtesttesttesttesttesttesttest'
    image { Faker::File.file_name }
  end
end
