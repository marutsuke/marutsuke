# frozen_string_literal: true

class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  validate :image_size
  validates :text, length: { maximum: 800 }, allow_nil: true
  validates :evaluation, presence: true

  belongs_to :teacher
  belongs_to :answer

  enum evaluation: {
    not_submitted: 10, #データとして発生しないはず。
    checking: 20,
    submit_again: 30,
    complete: 40
  }

  private
  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
