class Teacher::TopController < Teacher::Base
  def top
    @lessons_to_check = current_teacher.lessons.to_check
    @lessons = current_teacher_school
               .lessons.includes(:teacher)
  end
end
