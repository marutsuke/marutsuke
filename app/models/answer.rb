# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  text        :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
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
