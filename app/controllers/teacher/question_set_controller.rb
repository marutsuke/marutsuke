class Teacher::QuestionSetController < Teacher::Base
  def index
    @lesson_groups = LessonGroup
    .in_open
    .have_lesson_taught_by(current_teacher)
    .min_school_grade_order
    @lesson = current_teacher.lessons.find_by(id: params[:lesson_id])
  end

  def lessons_show
    @lesson_group = LessonGroup.for_school(current_teacher_school).find(params[:id])
    @lessons = @lesson_group.lessons.includes(:teacher).taught_by(current_teacher)
  end

  def show
    @lesson = current_teacher_school.lessons.find(params[:id])
    @questions = @lesson.questions.id_not_nil
    @lesson_group = @lesson.lesson_group
    @question = @lesson.questions.new
  end

end
