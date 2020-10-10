# frozen_string_literal: true

class QuestionsController < UserBase
  def show
    @question = Question.find(params[:id])
    @status = @question.question_status_of(current_user).status
    @lesson = current_school&.lessons&.find(@question.lesson_id)
    @answers = current_user&.answers&.where(id: @question.answer_ids).order(created_at: "DESC")
  end
end
