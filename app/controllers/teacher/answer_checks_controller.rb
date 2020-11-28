class Teacher::AnswerChecksController < Teacher::Base

  def index
    @lesson_groups = LessonGroup
                      .have_lesson_taught_by(current_teacher)
                      .min_school_grade_order
    @lesson = current_teacher_school.lessons.find_by(id: params[:lesson_id])
  end

  def lessons_show
    @lesson_group = LessonGroup.for_school(current_teacher_school).find(params[:id])
    @lessons = @lesson_group.lessons
    end

  def show
    @lesson = current_teacher_school.lessons.find(params[:id])
  end


  private

end
