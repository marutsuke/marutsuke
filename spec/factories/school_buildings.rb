FactoryBot.define do
  factory :school_building do
    name { Faker::Company.unique.name }
    association :school, factory: [:school]
  end
end
