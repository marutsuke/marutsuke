class SmallQuestion < ApplicationRecord

  belongs_to :question
  belongs_to :section
  belongs_to :book
  has_many :answers, dependent: :destroy
  mount_uploader :image, ImageUploader
end
