# frozen_string_literal: true

FactoryBot.define do
  factory :question_status do
    association :user, factory: [:user]
    association :question, factory: [:question]
    status  { :unselected }
    trait(:will_do) { status { :will_do } }
    trait(:maybe_do) { status { :maybe_do } }
    trait(:will_not_do) { status { :will_not_do } }
    trait(:checking) { status { :checking } }
    trait(:commented) { status { :commented } }
    trait(:comment_checked) { status { :comment_checked } }
    trait(:complete) { status { :complete } }
    trait(:will_submit_again) { status { :will_submit_again } }
  end
end
