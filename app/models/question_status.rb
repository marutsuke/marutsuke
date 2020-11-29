# frozen_string_literal: true

# == Schema Information
#
# Table name: question_statuses
#
#  id          :bigint           not null, primary key
#  status      :integer          default("unselected"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_question_statuses_on_question_id  (question_id)
#  index_question_statuses_on_user_id      (user_id)
#
class QuestionStatus < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :question_id, case_sensitive: true }

  enum status: {
    unselected: 10,
    will_do: 20,
    maybe_do: 30,
    will_not_do: 40,
    checking: 50,
    commented: 60,
    comment_checked: 70,
    complete: 80,
    will_submit_again: 90
  }

  scope :order_by_question_order_at, lambda { |lesson|
    includes(:question)
      .where(question_id: lesson.questions.pluck(:id))
      .order('questions.display_order asc')
  }

  scope :for_question, lambda  { |question|
    where(question_id: question.id)
  }

  scope :submitted_status, lambda {
    where.not(status: ['unselected', 'will_do', 'maybe_do', 'will_not_do'])
  }

  scope :user_asc_order, lambda {
    order(user_id: :asc)
  }

  def next_question_status_to_check
    question
      .question_statuses
      .where('user_id > ?', user_id)
      .checking
      .user_asc_order
      .first
  end

  def prev_question_status_to_check
    question
      .question_statuses
      .where('user_id < ?', user_id)
      .checking
      .user_asc_order
      .last
  end

  def next_question_status_submitted
    question
      .question_statuses
      .where('user_id > ?', user_id)
      .submitted_status
      .user_asc_order
      .first
  end

  def prev_question_status_submitted
    question
      .question_statuses
      .where('user_id < ?', user_id)
      .submitted_status
      .user_asc_order
      .last
  end

  def prev_submitted_id
    question_statuses = question.question_status.where.order(user_id: :asc)
    question_status_submitted_ids = question_statuses.submitted.where.order(user_id: :asc)
    index = question_status_ids.index(id)
    question_status_ids[index + 1]
  end

  def next_question_first_submitted_question_status
    question
      .lesson
      .questions
      .have_any_question_status_submitted
      .where('display_order > ?', question.display_order)
      .first
      &.question_statuses
      &.first
  end

  def prev_question_first_submitted_question_status
    question
      .lesson
      .questions
      .have_any_question_status_submitted
      .where('display_order < ?', question.display_order)
      .last
      &.question_statuses
      &.first
  end

  def answers
    Answer.where(user_id: user_id, question_id: question_id)
  end
end
