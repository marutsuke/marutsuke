# frozen_string_literal: true

FactoryBot.define do
  factory :question_status do
    association :user, factory: [:user]
    association :question, factory: [:question]
    status :not_submitted
    trait(:not_submitted) { status { :not_submitted } }
    trait(:checking) { status { :checking } }
    trait(:submit_again) { status { :submit_again } }
    trait(:complete) { status { :complete } }
  end
end
