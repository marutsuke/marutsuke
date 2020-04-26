class School < ApplicationRecord
  validates :name, presence: {message:"名前を入力してください。"}, length: {maximum:10, message:"名前は10文字以内でお願いします。"}
end
