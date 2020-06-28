# frozen_string_literal: true

FactoryBot.define do
  factory :user_tag do
    association :user, factory: [:user]
    association :tag, factory: [:tag]
  end
end
