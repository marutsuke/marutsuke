# frozen_string_literal: true

class Teacher::SchoolBuildingsController < Teacher::Base
  def index
    @school_buildings = current_school.school_buildings
  end

  def new
    @school_building = SchoolBuilding.new
  end
end
