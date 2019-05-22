class SmallQuestion < ApplicationRecord

  belongs_to :question
  belongs_to :section
  belongs_to :book
  has_many :answers, dependent: :destroy
  has_many :correct_numbers
  has_many :small_questions, through: :correct_numbers
  mount_uploader :image, ImageUploader
  validates :text, presence:true
end
