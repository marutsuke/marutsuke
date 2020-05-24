# frozen_string_literal: true

class Question < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 20 }
  validate :image_size
  belongs_to :lesson
  has_many :answers

  scope :not_nil, -> { where.not(id: nil) }
  scope :display_order, -> { where.not(id: nil).order(display_order: :asc) }

  private

  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
