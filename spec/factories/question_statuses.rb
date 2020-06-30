# frozen_string_literal: true

FactoryBot.define do
  factory :question_status do
    association :user, factory: [:user]
    association :question, factory: [:question]
    status 10
  end
end
