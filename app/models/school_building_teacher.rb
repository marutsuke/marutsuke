# frozen_string_literal: true

class SchoolBuildingTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_building

  validates :school_building_id, uniqueness: { scope: :teacher_id, case_sensitive: true }

  scope :main_order, lambda {
    order(main: 'desc')
  }
end
