# frozen_string_literal: true

class Teacher::SchoolBuildingsController < Teacher::Base
  skip_before_action :school_must_have_school_building

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

  private

  def school_building_params
    params.require(:school_building).permit(:name)
  end
end
