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

  def invitaion_manage

  end

  def update

  end

  private

  def school_building_params
    params.require(:school_building).permit(:name)
  end

  def set_school_building
    @school_building = current_teacher_school.school_buildings.find(params[:id])
  end
end
