class School < ApplicationRecord
  validates :name, presence: {message:"学校名を入力してください。"}, length: {maximum: 20, message:"名前は20文字以内でお願いします。"}
  has_many :teachers
  has_many :users
end
