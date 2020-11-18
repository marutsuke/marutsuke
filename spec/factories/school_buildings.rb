FactoryBot.define do
  factory :school_building do
    name { Faker::Company.unique.name[0..10] }
    association :school, factory: [:school]
    invitation_code { Faker::Internet.password(min_length: 8) }
  end
end
