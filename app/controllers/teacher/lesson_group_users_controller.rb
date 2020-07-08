class Teacher::LessonGroupUsersController < Teacher::Base
  before_action :set_user

  def new
    @lesson_group_user = @user.lesson_group_users.new
  end

  def create
    @lesson_group_user =
      @user
      .lesson_group_users
      .new(lesson_group_user_params)
  end

  private

  def lesson_group_user_params
    pramas.require(:lesson_group_user).permit(:user_id, :lesson_group_user_id)
  end

  def set_user
    @user = current_school.users.find(params[:user_id])
  end
end
