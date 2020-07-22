# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name[0..10] }
    email { Faker::Internet.unique.email }
    sequence(:login_id) { |n| n }
    password  { 'password' }
    start_at { 1.day.ago }
    end_at { 1.year.since }
    activated {  true }
    association :school, factory: [:school]
  end
end
