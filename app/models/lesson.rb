# frozen_string_literal: true

class Lesson < ApplicationRecord
  attr_accessor :start_at_date, :start_at_hour, :start_at_min,
                :end_at_date, :end_at_hour, :end_at_min
  validates :name, presence: true, length: { maximum: 30 }

  before_save { start_at_set }
  before_save { end_at_set }
  belongs_to :school
  belongs_to :teacher
  has_many :questions, dependent: :destroy
  has_many :lesson_tags
  has_many :tags, through: :lesson_tags
  accepts_nested_attributes_for :lesson_tags, allow_destroy: true

  scope :going_to, -> { where('start_at > ?', Time.zone.now) }

  scope :doing, lambda {
    where('start_at <= ?', Time.zone.now)
      .where('end_at >= ?', Time.zone.now)
      .or(
        Lesson.where('start_at <= ?', Time.zone.now)
            .where(end_at: nil)
      )
      .or(
        Lesson.where('end_at >= ?', Time.zone.now)
        .where(start_at: nil)
      )
      .or(
        Lesson.where(end_at: nil)
        .where(start_at: nil)
      )
  }

  scope :done, -> { where('end_at < ?', Time.zone.now) }

  private

  def start_at_set
    if start_at_date.present? && start_at_hour.present? && start_at_min.present?
      self.start_at = Time.zone.parse("#{start_at_date} #{start_at_hour}:#{start_at_min}:00")
    end
  end

  def end_at_set
    if end_at_date.present? && end_at_hour.present? && end_at_min.present?
      self.end_at = Time.zone.parse("#{end_at_date} #{end_at_hour}:#{end_at_min}:00")
    end
  end
end
