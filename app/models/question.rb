# frozen_string_literal: true

class Question < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 20 }
  belongs_to :lesson
end
