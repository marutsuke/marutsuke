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

  def answers
    Answer.where(user_id: user_id, question_id: question_id)
  end
end
