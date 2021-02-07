# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    name { Faker::Name.unique.name[0..10] }
    email { Faker::Internet.unique.email }
    login_id { Faker::Alphanumeric.unique.alpha(number: 10) }
    password { 'password' }
    start_at { 1.day.ago }
    end_at { 1.year.since }
    activation_digest  {'fljahfljdshalf' }
    activated  {true }
    association :school, factory: [:school]
    after(:create) do |teacher|
      school_building = create(:school_building, school: teacher.school)
      create(:school_building_teacher, teacher: teacher, school_building: school_building, main: true)
      lesson_group = create(:lesson_group, school_building: school_building)
      lesson = create(:lesson, lesson_group: lesson_group, teacher: teacher, school: teacher.school)
    end
  end
end
