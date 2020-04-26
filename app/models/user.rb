class User < ApplicationRecord
  validates :name, presence: {message:"名前を入力してください。"}
  # , length: {maximum:12, message:"名前は10文字以内でお願いします。"}
  validates :login_id, presence: {message:"ログインIDを入力してください。"}, uniqueness: {message: "同じログインIDが存在します。別のIDに変えてください。"}, length: {maximum: 12, message:"ログインIDは、12文字以内となります。"}
  validates :password, presence: true, confirmation: true
  has_secure_password

  belongs_to :school
  has_many :small_questions, through: :correct_numbers
end
