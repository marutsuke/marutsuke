# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name[0..10] }
    email { Faker::Internet.unique.email }
    password  { 'password' }
    birth_day  { Faker::Date.birthday(min_age: 4, max_age: 90) }
    after(:create) do |user|
      user_authentication = create(:user_authentication, user: user)
      school = create(:school)
      school_2 = create(:school)
      school_user = create(:school_user, school: school, user: user)
      school_user_2 = create(:school_user, school: school_2, user: user)
      school_building = create(:school_building, school: school)
      school_building_user = create(:school_building_user, user: user, school_building: school_building, main: true)
    end
  end
end
