# frozen_string_literal: true

FactoryBot.define do
  factory :lesson_group_user do
    association :user, factory: [:user]
    association :lesson_group, factory: [:lesson_group]
  end
end
