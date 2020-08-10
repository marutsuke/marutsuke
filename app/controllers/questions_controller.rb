# frozen_string_literal: true

class QuestionsController < UserBase
  def show
    @question = Question.find(params[:id])
    @lesson = current_school&.lessons&.find(@question.lesson_id)
    @answers = current_user&.answers&.where(id: @question.answer_ids).order(created_at: "DESC")
  end
end
