# frozen_string_literal: true

class Question < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, length: { maximum: 20 }
  validate :image_size
  belongs_to :lesson
  has_many :answers
  has_many :question_statuses
  scope :not_nil, -> { where.not(id: nil) }
  scope :display_order, -> { where.not(id: nil).order(display_order: :asc) }

  scope :checking, lambda {
    joins(:question_statuses)
      .where(question_statuses: { status: :checking })
  }

  scope :checking_distinct, lambda {
    joins(:question_statuses)
      .includes(:question_statuses)
      .where(question_statuses: { status: :checking })
  }

  scope :submit_again, lambda {
    joins(:question_statuses)
      .where(question_statuses: { status: :submit_again })
  }

  scope :submit_again_distinct, lambda {
    joins(:question_statuses)
      .includes(:question_statuses)
      .where(question_statuses: { status: :submit_again })
  }

  scope :complete, lambda {
    joins(:question_statuses)
      .where(question_statuses: { status: :complete })
  }

  scope :complete_distinct, lambda {
    joins(:question_statuses)
      .includes(:question_statuses)
      .where(question_statuses: { status: :complete })
  }

  scope :not_submitted, lambda {
    left_outer_joins(:question_statuses)
      .where(question_statuses: { id: nil })
  }

  private

  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
