class Teacher::TopController < Teacher::Base
  def top
    base_lessons = current_teacher.lessons
    @lessons_to_check = base_lessons.to_check
    @lessons_no_question = base_lessons.no_question.doing
    @lessons_has_unpublish_question = base_lessons.has_unpublish_question.doing
  end
end
