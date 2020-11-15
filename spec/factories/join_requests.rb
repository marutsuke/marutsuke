FactoryBot.define do
  factory :join_request do
    association :user, factory: [:user]
    association :school, factory: [:school]
    association :school_building, factory: [:school_building]
  end
end
