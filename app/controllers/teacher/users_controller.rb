# frozen_string_literal: true

class Teacher::UsersController < Teacher::Base
  before_action :search_users, only: :index

  def index
    @users = @users.page(params[:page])
  end

  def show
    @user = current_teacher_school.users.find(params[:id]).decorate
    @school_user = @user.school_user(current_teacher_school)
    @lesson_groups = @user.lesson_groups_in(current_teacher_school)
  end

  def edit
    @user = current_teacher_school.users.find(params[:id]).decorate
    @school_user = @user.school_user(current_teacher_school)
  end

  private

  def search_users
    @q = current_teacher_school.users.ransack(params[:q])
    @users = @q.result(distinct: true)
    # セレクトボックスの初期値設定のため
    if params[:q]
      @lesson_group_id = params[:q][:lesson_group_users_lesson_group_id_eq]
      @school_building_id = params[:q][:school_building_users_school_building_id_eq]
    end
  end

end
