class Teacher::AnswerChecksController < Teacher::Base

  def index
    @lesson_group = current_teacher
  end


  private

end
