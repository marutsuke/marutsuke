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
    @questions = @lesson.questions.display_order
    @lesson_group = @lesson.lesson_group
  end

  def question_statuses_show
    @question = Question.published.find(params[:id])
    @lesson = current_teacher_school.lessons.find(@question.lesson_id)
  end


  private

end
