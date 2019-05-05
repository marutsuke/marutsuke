class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :small_questions
  validates :title, presence:true
  validates :title, uniqueness: true
  validates :title, length: {maximum: 8}

  mount_uploader :image, ImageUploader
end
