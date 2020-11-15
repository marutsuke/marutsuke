# frozen_string_literal: true

class SchoolBuilding < ApplicationRecord
  belongs_to :school
  has_many :school_building_users
  has_many :users, through: :school_building_users
  has_many :school_users
  has_many :school_building_teachers
  has_many :teachers, through: :school_building_teachers
  has_many :lesson_groups
  has_many :join_requests

  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :school_id, case_sensitive: true }
  validates :invitation_code, uniqueness: true

end
