class Answer < ApplicationRecord
  belongs_to :small_question
  mount_uploader :image, ImageUploader
end
