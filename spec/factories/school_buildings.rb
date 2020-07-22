FactoryBot.define do
  factory :school_building do
    name { Faker::Company.unique.name[0..10] }
    association :school, factory: [:school]
  end
end
