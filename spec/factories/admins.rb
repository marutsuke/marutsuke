FactoryBot.define do
  factory :admin do
    name { Faker::Name.unique.name[0..10] }
    email { Faker::Internet.unique.email }
    password { "systring" }
  end
end
