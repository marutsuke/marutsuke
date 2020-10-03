# frozen_string_literal: true

class Question < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :text, presence: true, length: { maximum: 3000 }
  validate :image_size
  belongs_to :lesson
  has_many :answers
  has_many :question_statuses

  scope :not_nil, -> { where.not(id: nil) }
  scope :display_order, -> { not_nil.order(display_order: :asc) }
  scope :published, -> { where(publish: true) }
  scope :unpublish, -> { where(publish: false) }

  scope :unselected, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :unselected })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :unselected })
    end
  }

  scope :will_do, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :will_do })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :will_do })
    end
  }

  scope :maybe_do, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :maybe_do })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :maybe_do })
    end
  }

  scope :will_not_do, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :will_not_do })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :will_not_do })
    end
  }

  scope :checking, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :checking })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :checking })
    end
  }

  scope :commented, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :commented })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :commented })
    end
  }

  scope :comment_checked, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :comment_checked })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :comment_checked })
    end
  }

  scope :complete, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :complete })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :complete })
    end
  }

  scope :will_submit_again, ->  (distinct: false) {
    if distinct
      joins(:question_statuses)
        .includes(:question_statuses)
        .where(question_statuses: { status: :will_submit_again })
    else
      joins(:question_statuses)
        .where(question_statuses: { status: :will_submit_again })
    end
  }

  scope :any_user_unchecked, lambda {
    left_outer_joins(:question_statuses)
      .where(question_statuses: { id: nil })
  }

  def question_status_of(user)
    question_statuses.find_by(user_id: user.id)
  end

  def title
    title = text[0..10]
    title += '...' if text.length  > 10
  end

  def image_alt
    lesson_group = lesson.lesson_group
    "#{ lesson_group.name }/#{ lesson.name }: #{ title }"
  end

  private

  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
