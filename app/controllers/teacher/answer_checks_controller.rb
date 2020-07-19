class Teacher::AnswerChecksController < Teacher::Base
  before_action :set_question_and_lesson

  def checking
  end

  private

  def set_question_and_lesson

  end

  def set_page
    @page = params[:page] || 1
  end

  def set_lesson
    @lesson = current_teacher.lessons.find(pramas[:lesson_id])
  end

  def set_answer
    @question_status =
      QuestionStatus.order_by_question_order_at(@lesson)
  end
end
