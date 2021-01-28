# frozen_string_literal: true

class Teacher::UsersController < Teacher::Base
  before_action :search_users, only: %i[index]

  def index
    @users = @users.page(params[:page])
  end

  def show
    @user = current_teacher_school.users.find(params[:id]).decorate
    @school_user = @user.school_user(current_teacher_school)
    @lesson_groups = @user.lesson_groups_in(current_teacher_school)
  end

  def lesson_groups
    @user = current_teacher_school.users.find(params[:id]).decorate
    @school_user = @user.school_user(current_teacher_school)
    @lesson_groups = @user.lesson_groups_in(current_teacher_school)
  end

  private

  def search_users
    @q = current_teacher_school_building.users.ransack(params[:q])
    @users = @q.result(distinct: true)
    # セレクトボックスの初期値設定のため
    if params[:q]
      @lesson_group_id = params[:q][:lesson_group_users_lesson_group_id_eq]
      @school_grade = params[:q][:school_grade_eq]
    end
  end

end
