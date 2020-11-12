# frozen_string_literal: true

class SchoolBuilding < ApplicationRecord
  belongs_to :school
  has_many :school_building_users
  has_many :users, through: :school_building_users
  has_many :school_users
  has_many :school_building_teachers
  has_many :teachers, through: :school_building_teachers
  has_many :lesson_groups
  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :school_id, case_sensitive: true }
  validates :invitation_code, uniqueness: true

  def invite_user(user)
    if user.school_users.pluck(:school_id).include?(school_id)
      return false
    else
      user.school_users.create(school_id: school.id, school_building_id: id)
      user.school_building_users.create(school_building_id: id, main: true)
    end
  end
end
