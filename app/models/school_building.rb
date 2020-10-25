# frozen_string_literal: true

# == Schema Information
#
# Table name: school_buildings
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :bigint
#
# Indexes
#
#  index_school_buildings_on_school_id  (school_id)
#
class SchoolBuilding < ApplicationRecord
  belongs_to :school
  has_many :school_building_users
  has_many :users, through: :school_building_users
  has_many :school_building_teachers
  has_many :teachers, through: :school_building_teachers
  has_many :lesson_groups
  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :school_id, case_sensitive: true }
end
