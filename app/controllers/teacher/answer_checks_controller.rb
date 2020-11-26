class Teacher::AnswerChecksController < Teacher::Base

  def index
    @lesson_groups = LessonGroup
                      .have_lesson_taught_by(current_teacher)
                      .min_school_grade_order
  end

  end


  private

end
