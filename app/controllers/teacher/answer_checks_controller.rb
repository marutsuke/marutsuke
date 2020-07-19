class Teacher::AnswerChecksController < Teacher::Base
  before_action :set_lesson, :set_answers

  def checking
  end

  private

  def set_question_and_lesson

  end

  def set_page
    @page = params[:page] || 1
  end

  def set_lesson
    @lesson = current_teacher.lessons.find(params[:lesson_id])
  end

  def set_answers
    @question_status =
      QuestionStatus.order_by_question_order_at(@lesson)[0]
    @question = @question_status.question
    @answers = @question_status.answers.new_order 
  end
end
