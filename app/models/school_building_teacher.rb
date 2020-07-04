class SchoolBuildingTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_building
end
