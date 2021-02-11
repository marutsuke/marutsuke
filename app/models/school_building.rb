# frozen_string_literal: true

class SchoolBuilding < ApplicationRecord
  belongs_to :school
  has_many :school_building_users
  has_many :users, through: :school_building_users
  has_many :school_building_teachers
  has_many :teachers, through: :school_building_teachers
  has_many :lesson_groups
  has_many :join_requests
  has_many :lesson_group_requests

  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :school_id, case_sensitive: true }
  validates :invitation_code, uniqueness: { case_sensitive: true }, length: { minimum: 8 }, presence: true, format: { with: VALIDATE_FORMAT_OF_ID, message: "は#{VALIDATE_FORMAT_OF_ID_TEXT}です" }

  def active_users
    active_user_ids = school.school_users.active.pluck(:user_id)
    school_building_users.where(user_id: active_user_ids, main: true)
  end

end
