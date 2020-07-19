# frozen_string_literal: true

class QuestionStatus < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :status, presence: true

  enum status: {
    not_submitted: 10, #データとして発生しないはず。
    checking: 20,
    submit_again: 30,
    complete: 40
  }

  scope :order_by_lesson, lambda { |lesson|
    includes(:question)
      .where(question_id: lesson.questions.pluck[:id])
      .order('questions.display_order asc')
  }

end
