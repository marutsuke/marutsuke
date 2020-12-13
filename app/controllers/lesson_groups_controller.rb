class LessonGroupsController < UserBase

  def index
    @lesson_groups = current_user.lesson_groups
  end

  def show
    @lesson_group = current_user.lesson_groups.find(params[:id])
    @lessons = @lesson_group.lessons
  end
end
