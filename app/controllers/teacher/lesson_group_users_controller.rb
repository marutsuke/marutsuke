# frozen_string_literal: true

class Teacher::LessonGroupUsersController < Teacher::Base
  before_action :set_user

  def new
    @lesson_group_user = @user.lesson_group_users.new
    @lesson_groups = LessonGroup.for_school_buildings_belonged_to_teacher_and_user(current_teacher, @user) - @user.lesson_groups
  end

  def create
    @lesson_group_user =
      @user
      .lesson_group_users
      .new(lesson_group_user_params)
    if @lesson_group_user.save
      flash[:success] = '登録に成功しました。'
      redirect_to new_teacher_user_lesson_group_user_path(@user)
    else
      render :new
    end
  end

  def destroy
    @lesson_group_user = @user.lesson_group_users.find(params[:id])
    @lesson_group_user.destroy
    flash[:danger] = '削除に成功しました。'
    redirect_to new_teacher_user_lesson_group_user_path(@user)
  end

  private

  def lesson_group_user_params
    params.require(:lesson_group_user).permit(:lesson_group_id)
  end

  def set_user
    @user = current_teacher_school.users.find(params[:user_id])
  end
end
