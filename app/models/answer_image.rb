# frozen_string_literal: true

class AnswerImage < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :answer
  validate :image_size

  private

  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
