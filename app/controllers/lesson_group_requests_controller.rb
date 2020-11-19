class LessonGroupRequestsController < UserBase
  def index
    @lesson_groups = current_school
  end

  def create
  end
end
