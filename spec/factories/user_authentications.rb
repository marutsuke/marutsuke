FactoryBot.define do
  factory :user_authentication do
    association :user, factory: [:user]
    uid { Faker::Internet.unique.email }
    provider { 'email' }
  end
end
