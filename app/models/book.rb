class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :small_questions
  validates :title, presence: {message: "タイトルを入力してください。"}
  validates :title, uniqueness: {message: "同じタイトルの本があります。変更してください。"}
  validates :title, length: {maximum: 10, message:"タイトルは10文字以内で入力してください。"}

  mount_uploader :image, ImageUploader
end
