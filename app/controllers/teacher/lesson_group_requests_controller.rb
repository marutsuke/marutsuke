class Teacher::LessonGroupRequestsController < Teacher::Base
  def index
    @lesson_group_requests = current_teacher_school_building.lesson_group_requests.requested
    @checked_lesson_group_requests = current_teacher_school_building.lesson_group_requests.checked_recently_lgr
  end

  def accept
  end

  def reject
  end

end
