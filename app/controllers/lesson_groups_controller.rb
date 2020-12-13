class LessonGroupsController < UserBase

  def index
    @lesson_groups = current_user.lesson_groups
  end
end
