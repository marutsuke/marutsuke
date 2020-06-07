# frozen_string_literal: true

FactoryBot.define do
  factory :user_tag do
    association :school, factory: [:user]
    association :school, factory: [:tag]
  end
end
