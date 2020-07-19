class Teacher::AnswerChecksController < Teacher::Base
  before_action :set_lesson

  def checking
    @questions =
      @lesson
      .questions
      .checking_distinct
  end

  private

  def set_lesson
    @lesson = current_teacher.lessons.to_check.find(params[:lesson_id])
  end
end
