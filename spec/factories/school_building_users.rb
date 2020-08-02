# frozen_string_literal: true

FactoryBot.define do
  factory :school_building_user do
    association :user, factory: [:user]
    association :school_building, factory: [:school_building]
    main  { true }

    trait(:sub) { main { false } }
  end
end
