# frozen_string_literal: true

# == Schema Information
#
# Table name: school_building_teachers
#
#  id                 :bigint           not null, primary key
#  main               :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  school_building_id :bigint
#  teacher_id         :bigint
#
# Indexes
#
#  index_school_building_teachers_on_school_building_id  (school_building_id)
#  index_school_building_teachers_on_teacher_id          (teacher_id)
#
class SchoolBuildingTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_building

  validates :school_building_id, uniqueness: { scope: :teacher_id, case_sensitive: true }

  scope :main_order, lambda {
    order(main: 'desc')
  }
end
