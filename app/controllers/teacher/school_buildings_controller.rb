# frozen_string_literal: true

class Teacher::SchoolBuildingsController < Teacher::Base
  skip_before_action :school_must_have_school_building
  before_action :set_school_building, only: %i[show invitation_manage update]

  def index
    @school_buildings = current_teacher_school.school_buildings
  end

  def new
    @school_building = SchoolBuilding.new
  end

  def create
    @school_building = current_teacher_school.school_buildings.new(school_building_params)
    if @school_building.save
      flash[:success] = "#{@school_building.name}を作成しました"
      redirect_to new_teacher_school_building_path
    else
      render :new
    end
  end

  def show
  end

  def invitation_manage
  end

  def update
    if @school_building.update(school_building_params)
      flash[:success] = '更新しました'
      redirect_to invitation_manage_teacher_school_building_path(@school_building)
    else
      render :invitation_manage
    end
  end

  private

  def school_building_params
    params.require(:school_building).permit(:name, :invitation_code, :auto_invite, :invite_code_availability)
  end

  def set_school_building
    @school_building = current_teacher_school.school_buildings.find(params[:id])
  end
end
