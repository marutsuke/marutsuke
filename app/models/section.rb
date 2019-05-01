class Section < ApplicationRecord

  belongs_to :chapter
  has_many :questions, dependent: :destroy
  has_many :small_questions
  mount_uploader :image, ImageUploader
  validates :section, presence:true

end
