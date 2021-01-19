FactoryBot.define do
  factory :cancel_reason do
    association :user, factory: [:user]
    reason { :school_canceled }
    text { '' }
    confirm { false }
  end
end
