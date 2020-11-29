# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  evaluation :integer          default(10), not null
#  image      :string(255)
#  text       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint
#  teacher_id :bigint
#
# Indexes
#
#  index_comments_on_answer_id   (answer_id)
#  index_comments_on_teacher_id  (teacher_id)
#
class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  validate :image_size
  validates :text, length: { maximum: 800 }, allow_nil: true
  validates :text, presence: true

  belongs_to :teacher
  belongs_to :answer


  private
  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
