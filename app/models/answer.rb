# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :text, length: { maximum: 800 }, allow_nil: true
  belongs_to :user
  belongs_to :question
  has_many :answer_images, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :created_desc_order, -> {
    order(created_at: :desc)
  }

  def send_notification_email_to_teacher
    return if question.lesson.teacher.email.blank?

    TeacherNotificationMailer.notification_of_answer(self).deliver_now
  end

  def question_status
    QuestionStatus.find_by(user_id: user_id, question_id: question_id)
  end
end
