# frozen_string_literal: true

class Teacher::SchoolBuildingUsersController < Teacher::Base
  before_action :set_user_and_school_buildings, except: %i[new create]

  def new
    @user = current_teacher_school.users.find(params[:user_id])
  end

  def create
    @user = current_teacher_school.users.find(params[:user_id])
    @school_building = current_teacher_school.school_buildings.find(params[:id])
    @school_building_user = @user.school_building_users.new(school_building_id: @school_building.id, main: false)
    if @school_building_user.save
      flash[:success] = '所属になりました'
      redirect_to new_teacher_user_school_building_user_path(@user)
    else
      render :new
    end
  end

  def update
    if @user
        .school_building_users
        .in_school(current_teacher_school)
        .find_by(main: true)
        .update(main: false)
      @school_building_user.update(main: true)
      flash[:success] = '本所属を変更しました'
      redirect_to new_teacher_user_school_building_user_path(@user)
    else
      flash[:danger] = 'エラーです'
      redirect_to new_teacher_user_school_building_user_path(@user)
    end
  end

  def destroy
    @school_building_user.destroy
    flash[:danger] = '所属を外しました'
    redirect_to new_teacher_user_school_building_user_path(@user)
  end

  private

  def set_user_and_school_buildings
    @user = current_teacher_school.users.find(params[:user_id])
    @school_building = current_teacher_school.school_buildings.find(params[:id])
    @school_building_user = @user.school_building_users.find_by(school_building_id: @school_building.id)
  end
end
