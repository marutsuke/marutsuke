class Teacher::TopController < Teacher::Base
  def top
    @lessons_to_check = current_teacher.lessons.to_check
  end
end
