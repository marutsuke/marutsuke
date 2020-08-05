# frozen_string_literal: true

class Teacher::SchoolBuildingUsersController < Teacher::Base
  before_action :set_user
  before_action :main_setting, only: :create
  def new
    @school_building_user = @user.school_building_users.new
  end

  def create
    @school_building_user =
      @user
      .school_building_users
      .new(school_building_user_params)
    if @user.main_school_building(current_school).nil?
      @school_building_user.update(main: true)
    end
    if @school_building_user.save
      flash[:success] = '登録に成功しました。'
      redirect_to new_teacher_user_school_building_user_path(@user)
    else
      render :new
    end
  end

  def destroy
    @school_building_user = @user.school_building_users.find(params[:id])
    @school_building_user.destroy
    flash[:danger] = '削除に成功しました。'
    redirect_to new_teacher_user_school_building_user_path(@user)
  end

  private

  def school_building_user_params
    params.require(:school_building_user).permit(:school_building_id, :main)
  end

  def main_setting
    if school_building_user_params[:main] == '1'
      @user.school_building_users.update_all(main: false)
    else
      school_building_user_params[:main] = false
    end
  end

  def set_user
    @user = current_school.users.find(params[:user_id])
  end
end
