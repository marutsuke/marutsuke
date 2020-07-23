# frozen_string_literal: true

FactoryBot.define do
  factory :school do
    name { Faker::Company.unique.name[0..10] }
    login_path { Faker::Internet.unique.domain_word }
  end
end
