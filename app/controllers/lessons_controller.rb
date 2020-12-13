# frozen_string_literal: true

class LessonsController < UserBase
  before_action :set_lesson_and_questions, only: [:show]
  before_action :question_status_find_or_create, only: [:show]

  def show
  end

  private

  def set_lesson_and_questions
    @lesson = current_school&.lessons&.find(params[:id])
    @questions = @lesson.questions&.published&.display_order
  end

  def question_status_find_or_create
    question_ids = @questions.pluck(:id)
    question_ids.each do |question_id|
      QuestionStatus.find_or_create_by(user_id: current_user.id, question_id: question_id)
    end
  end

end
