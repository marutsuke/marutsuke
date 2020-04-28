FactoryBot.define do
  factory :teacher do
    name "MyString"
    email "MyString"
    password_digest "MyString"
    school_id 1
    start_at "2020-04-28"
    end_date "2020-04-28"
    activated false
  end
end
