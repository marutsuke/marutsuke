class Chapter < ApplicationRecord
  belongs_to :book
  has_many :sections, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :chapter, presence:true
end
