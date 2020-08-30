# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :text, length: { maximum: 800 }, allow_nil: true
  belongs_to :user
  belongs_to :question
  has_many :answer_images
  has_many :comments

  scope :new_order, -> {
    order(created_at: :desc)
  }

  def question_status
    QuestionStatus.find_by(user_id: user_id, question_id: question_id)
  end
end
