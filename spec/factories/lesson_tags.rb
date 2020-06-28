# frozen_string_literal: true

FactoryBot.define do
  factory :lesson_tag do
    association :lesson, factory: [:lesson]
    association :tag, factory: [:tag]
  end
end
