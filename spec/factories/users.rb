# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name[0..10] }
    email { Faker::Internet.unique.email }
    password  { 'password' }
    start_at { 1.day.ago }
    end_at { 1.year.since }
    activated {  true }
    after(:create) do |user|
      school = create(:school)
      school_2 = create(:school)
      school_user = create(:school_user, school: school, user: user)
      school_user_2 = create(:school_user, school: school_2, user: user)
      school_building = create(:school_building, school: school)
      school_building_user = create(:school_building_user, user: user, school_building: school_building, main: true)
    end
  end
end
