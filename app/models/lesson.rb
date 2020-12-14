# frozen_string_literal: true

class Lesson < ApplicationRecord
  attr_accessor :start_at_date, :start_at_hour, :start_at_min,
                :end_at_date, :end_at_hour, :end_at_min
  validates :name, presence: true, length: { maximum: 30 }
  validate :start_at_and_end_at_validate

  before_save { start_at_set }
  before_save { end_at_set }
  belongs_to :school
  belongs_to :teacher
  belongs_to :lesson_group
  has_many :questions, dependent: :destroy

  paginates_per 20

  scope :going_to, -> { where('start_at > ?', Time.zone.now) }

  scope :doing, lambda {
    where('start_at <= ?', Time.zone.now)
      .where('end_at >= ?', Time.zone.now)
      .or(
        where('start_at <= ?', Time.zone.now)
          .where(end_at: nil)
      )
      .or(
        where('end_at >= ?', Time.zone.now)
          .where(start_at: nil)
      )
      .or(
        where(end_at: nil)
          .where(start_at: nil)
      )
  }

  scope :done, -> { where('end_at < ?', Time.zone.now) }

  scope :to_check, lambda {
    joins(:questions)
      .includes(:questions)
      .merge(Question.checking)
  }

  scope :no_question, lambda {
    left_outer_joins(:questions)
      .where(questions: { id: nil })
  }

  scope :has_unpublish_question, lambda{
    joins(:questions)
      .includes(:questions)
      .merge(Question.unpublish)
  }

  scope :has_published_question, lambda{
    joins(:questions)
      .includes(:questions)
      .merge(Question.published)
  }

  def will_do_count_of(user)
    user.question_statuses.will_do.where(question_id: questions.pluck(:id)).size
  end

  def to_judge_questions_count_of(user)
    unselected_count_of(user) + have_not_seen_count_of(user)
  end

  def unselected_count_of(user)
    user.question_statuses.unselected.where(question_id: questions.pluck(:id)).size
  end

  def have_not_seen_count_of(user)
    questions.size - user.question_statuses.where(question_id: questions.pluck(:id)).size
  end

  def unchecked_comment_count_of(user)
    user.question_statuses.commented.where(question_id: questions.pluck(:id)).size
  end

  def during_the_period?
    start_at < Time.zone.now && (end_at.nil? || Time.zone.now < end_at)
  end

  def checking_count
    questions.checking.size
  end

  def complete_count
    questions.complete.size
  end

  def first_question_to_check
    questions.checking_distinct.first
  end

  def question_statuses_to_check
    QuestionStatus.checking.order_by_question_order_at(self)
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
    if end_at_date.blank? && end_at_hour.blank? && end_at_min.blank?
      self.end_at = nil
    end
  end

  def start_at_and_end_at_validate
    return if end_at.nil?

    errors.add(:end_at, 'はアカウント開始日時より後にしてください。') unless start_at < end_at
  end

end
