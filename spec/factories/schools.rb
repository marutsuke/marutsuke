FactoryBot.define do
  factory :school do
    name { Faker::Company.unique.name }
  end
end
