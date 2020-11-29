FactoryBot.define do
  factory :lesson_group_request do
    association :user, factory: [:user]
    association :lesson_group, factory: [:lesson_group]
    association :school_building, factory: [:school_building]
    status { :requested }
  end
end
