# frozen_string_literal: true

class AnswerImage < ApplicationRecord
  belongs_to :answer
  mount_uploader :image, ImageUploader
end
