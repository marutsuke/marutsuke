# frozen_string_literal: true

class Question < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 20 }
  validate :image_size
  belongs_to :lesson

  private

  def image_size
    errors.add(:picture, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
