# frozen_string_literal: true

class Teacher::LessonGroupUsersController < Teacher::Base
  before_action :set_user

  def new
    @lesson_groups = current_teacher_school_building.lesson_groups.in_open
  end

  def create
    @user = current_teacher_school_building.users.find(params[:user_id])
    @lesson_group = current_teacher_school_building.lesson_groups.find(params[:id])

    @lesson_group_user = @user.lesson_group_users.new(lesson_group_id: @lesson_group.id)

    if @lesson_group_user.save
      flash[:success] = '登録しました。'
      redirect_to new_teacher_user_lesson_group_user_path(@user)
    else
      flash[:success] = '失敗しました'
      redirect_to new_teacher_user_lesson_group_user_path(@user)
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
