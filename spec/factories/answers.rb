# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    text 'MyText'
    association :question, factory: [:question]
    association :user, factory: [:user]
  end
end
