# frozen_string_literal: true

class SchoolBuilding < ApplicationRecord
  belongs_to :school
  has_many :school_building_users
  has_many :users, through: :school_building_users
  has_many :school_building_teachers
  has_many :teachers, through: :school_building_teachers
  has_many :lesson_groups
  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :school_id }
end
