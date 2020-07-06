# frozen_string_literal: true

FactoryBot.define do
  factory :school_building_teacher do
    association :teacher, factory: [:teacher]
    association :school_building, factory: [:school_building]
    main true
  end
end
