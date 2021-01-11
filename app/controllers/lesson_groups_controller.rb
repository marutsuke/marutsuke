class LessonGroupsController < UserBase

  def index
    @lesson_groups = current_user.lesson_groups
      .for_school(current_school)
      .in_open
  end

  def show
    @lesson_group = current_user.lesson_groups
    .for_school(current_school)
    .find(params[:id])
    @lessons = @lesson_group.lessons
  end
end
