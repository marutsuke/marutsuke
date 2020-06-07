FactoryBot.define do
  factory :lesson_tag do
    association :school, factory: [:lesson]
    association :school, factory: [:tag]
  end
end
