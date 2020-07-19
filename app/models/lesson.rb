# frozen_string_literal: true

class Lesson < ApplicationRecord
  attr_accessor :start_at_date, :start_at_hour, :start_at_min,
                :end_at_date, :end_at_hour, :end_at_min
  validates :name, presence: true, length: { maximum: 30 }

  before_save { start_at_set }
  before_save { end_at_set }
  belongs_to :school
  belongs_to :teacher
  belongs_to :lesson_group
  has_many :questions, dependent: :destroy

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

  scope :to_check, lambda {
    joins(:questions)
      .includes(:questions)
      .merge(Question.checking)
  }

  def doing?
    start_at < Time.zone.now && (end_at.nil? || Time.zone.now < end_at)
  end

  def duration_judge_word
    doing? ? 'doing' : 'expired'
  end

  def cheking_count_td_class
    checking_count.positive? ? 'lesson_table__tr--red' : 'lesson_table__tr'
  end

  def not_submitted_count
    questions.size -
      checking_count -
      submit_again_count -
      complete_count
  end

  def checking_count
    questions.checking.size
  end

  def submit_again_count
    questions.submit_again.size
  end

  def complete_count
    questions.complete.size
  end

  def first_question_to_check
    questions.checking_distinct.first
  end

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
