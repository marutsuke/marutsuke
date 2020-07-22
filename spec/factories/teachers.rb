# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    start_at { 1.day.ago }
    end_at { 1.year.since }
    activation_digest  {'fljahfljdshalf' }
    activated  {true }
    association :school, factory: [:school]
    after(:create) do |teacher|
      school_building = create(:school_building, school: teacher.school)
      create(:school_building_teacher, teacher: teacher, school_building: school_building, main: true)
    end
  end
end
