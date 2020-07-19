class Teacher::AnswerChecksController < Teacher::Base
  before_action :set_question_and_lesson

  def checking
    @page = params[:page] || 1
  end

  private

  def set_question_and_lesson
    @question = Question.find(params[:question_id])
    @lesson = current_teacher.lessons.find(@question.lesson.id)
  end
end
