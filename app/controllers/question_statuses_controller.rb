class QuestionStatusesController < UserBase
  before_action :set_question

  def will_do
    @question.question_status_of(current_user).update(status: :will_do)
    redirect_to  @lesson
  end

  def maybe_do
    @question.question_status_of(current_user).update(status: :maybe_do)
    redirect_to  @lesson
  end

  def will_not_do
    @question.question_status_of(current_user).update(status: :will_not_do)
    redirect_to  @lesson
  end

  private
  def set_question
    @question = Question.find(params[:question_id])
    @lesson = current_school.lessons.find(@question.lesson_id)
  end
end
