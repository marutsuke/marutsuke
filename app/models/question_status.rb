# frozen_string_literal: true

class QuestionStatus < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :question_id, case_sensitive: true }
  enum status: {
    not_submitted: 10, #データとして発生しないはず。
    checking: 20,
    submit_again: 30,
    complete: 40
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
