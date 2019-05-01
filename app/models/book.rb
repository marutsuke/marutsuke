class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :small_questions
  mount_uploader :image, ImageUploader

  validates :title, presence:true
  validates :title, uniqueness: true
  validates :title, length: {maximum: 8}
end
