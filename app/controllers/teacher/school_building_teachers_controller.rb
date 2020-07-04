# frozen_string_literal: true

class Teacher::SchoolBuildingTeachersController < Teacher::Base
  before_action :clear_main, only: :create
  def new
    @school_building_teacher = current_teacher.school_building_teachers.new
  end

  def create
    @school_building_teacher =
      current_teacher
      .school_building_teachers
      .new(school_building_teacher_params)
    if @school_building_teacher.save
      flash[:success] = '登録に成功しました。'
      redirect_to new_teacher_school_building_teacher_path
    else
      render :new
    end
  end

  def destroy
    @school_building_teacher = current_teacher.school_building_teachers.find(params[:id])
    @school_building_teacher.destroy
    flash[:danger] = '削除に成功しました。'
    redirect_to new_teacher_school_building_teacher_path
  end

  private

  def school_building_teacher_params
    params.require(:school_building_teacher).permit(:school_building_id, :main)
  end

  def clear_main
    if school_building_teacher_params[:main]
      current_teacher.school_building_teachers.update_all(main: false)
    end
  end
end
