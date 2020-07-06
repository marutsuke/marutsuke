# frozen_string_literal: true

class Teacher::SchoolBuildingTeachersController < Teacher::Base
  before_action :main_setting, only: :create
  before_action :set_teacher
  def new
    @school_building_teacher = @teacher.school_building_teachers.new
  end

  def create
    @school_building_teacher =
      @teacher
      .school_building_teachers
      .new(school_building_teacher_params)
    if @school_building_teacher.save
      flash[:success] = '登録に成功しました。'
      redirect_to new_teacher_teacher_school_building_teacher_path(@teacher)
    else
      render :new
    end
  end

  def destroy
    @school_building_teacher = @teacher.school_building_teachers.find(params[:id])
    @school_building_teacher.destroy
    flash[:danger] = '削除に成功しました。'
    redirect_to new_teacher_teacher_school_building_teacher_path(@teacher)
  end

  private

  def school_building_teacher_params
    params.require(:school_building_teacher).permit(:school_building_id, :main)
  end

  def main_setting
    if school_building_teacher_params[:main] == '1'
      current_teacher.school_building_teachers.update_all(main: false)
    else
      school_building_teacher_params[:main] = false
    end
  end

  def set_teacher
    @teacher = current_school.teachers.find(params[:teacher_id])
  end
end
