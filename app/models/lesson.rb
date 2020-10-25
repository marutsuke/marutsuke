# frozen_string_literal: true

# == Schema Information
#
# Table name: lessons
#
#  id              :bigint           not null, primary key
#  end_at          :datetime
#  name            :string(255)
#  start_at        :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lesson_group_id :integer
#  school_id       :bigint
#  teacher_id      :bigint
#
# Indexes
#
#  index_lessons_on_school_id   (school_id)
#  index_lessons_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (school_id => schools.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
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

  def doing?
    start_at < Time.zone.now && (end_at.nil? || Time.zone.now < end_at)
  end

  def duration_judge_word
    doing? ? 'doing' : 'expired'
  end

  def cheking_count_td_class
    checking_count.positive? ? 'lesson_table__tr--red' : 'lesson_table__tr'
  end

  def will_submit_count
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
  end
end
