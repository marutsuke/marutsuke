# frozen_string_literal: true

class QuestionsController < UserBase
  after_action :comment_check, only: [:show]

  def show
    @question = Question.find(params[:id])
    @question_status = @question.question_status_of(current_user)
    @status = @question_status.status
    @lesson = current_school&.lessons&.find(@question.lesson_id)
    @answers = current_user&.answers&.where(id: @question.answer_ids).order(created_at: "ASC")
  end

  private
  def comment_check
    if @status == 'commented'
      @question_status.update(status: :comment_checked)
    end
  end

end
