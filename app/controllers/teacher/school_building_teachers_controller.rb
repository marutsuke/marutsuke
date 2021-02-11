# frozen_string_literal: true

class Teacher::SchoolBuildingTeachersController < Teacher::Base
  before_action :set_teacher
  skip_before_action :teacher_must_belong_to_school_building

  def new
    @page_from = params[:page_from]
  end

  def create
    @school_building = current_teacher_school.school_buildings.find(params[:id])
    @school_building_teacher = @teacher.school_building_teachers.new(school_building_id: @school_building.id, main: false)
    if @school_building_teacher.save
      @school_building_teacher.update(main: true) unless @teacher.main_school_building
      flash[:success] = '登録に成功しました。'
      redirect_to new_teacher_teacher_school_building_teacher_path(@teacher)
    else
      flash[:success] = '登録に失敗しました'
      render :new
    end
  end

  def destroy
    @school_building = @teacher.school_buildings.find(params[:id])
    @school_building_teacher = @teacher.school_building_teachers.find_by(school_building_id: @school_building.id)
    @school_building_teacher.destroy
    flash[:danger] = '削除に成功しました。'
    redirect_to new_teacher_teacher_school_building_teacher_path(@teacher)
  end

  def update
    @school_building = @teacher.school_buildings.find(params[:id])
    if @teacher.school_building_teachers.find_by(main: true).update(main: false)
      @teacher.school_building_teachers.find_by(school_building_id: @school_building.id).update(main: true)
      flash[:danger] = '本所属を変更しました。'
      redirect_to new_teacher_teacher_school_building_teacher_path(@teacher)
    end
  end

  private

  def set_teacher
    @teacher = current_teacher_school.teachers.find(params[:teacher_id])
  end
end
