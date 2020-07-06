# frozen_string_literal: true

class LessonGroup < ApplicationRecord
  belongs_to :school_building
  has_many :lesson_group_users
  has_many :users, through: :lesson_group_users
  has_many :lessons

  validates :name, presence: true, length: { maximum: 30 }

  scope :for_school_buildings_belonged_to, lambda { |teacher|
    where(school_building_id: teacher.school_building_teachers.pluck(:school_building_id))
  }
end
