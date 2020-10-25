# frozen_string_literal: true

# == Schema Information
#
# Table name: answer_images
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint
#
# Indexes
#
#  index_answer_images_on_answer_id  (answer_id)
#
class AnswerImage < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :answer
  validate :image_size

  private

  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
