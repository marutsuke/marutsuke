class SchoolBuildingTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_building

  scope :main_order, -> {
    order(main: 'desc')
  }
end
