class Answer < ApplicationRecord
  belongs_to :small_question
  validates :answer, presence:true
  mount_uploader :image, ImageUploader

end
