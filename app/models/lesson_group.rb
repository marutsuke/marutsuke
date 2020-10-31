# frozen_string_literal: true

class LessonGroup < ApplicationRecord
  belongs_to :school_building
  has_many :lesson_group_users
  has_many :users, through: :lesson_group_users
  has_many :lessons

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: [:school_building_id, :school_year] }

  scope :for_school_buildings_belonged_to_teacher_and_user,
        lambda { |teacher, user|
          for_school_buildings_belonged_to_teacher(teacher)
            .for_school_buildings_belonged_to_user(user)
        }

  scope :for_school_buildings_belonged_to_teacher, lambda { |teacher|
    where(school_building_id: teacher
            .school_building_teachers.pluck(:school_building_id))
  }

  scope :for_school_buildings_belonged_to_user, lambda { |user|
    where(school_building_id: user.school_building_users.pluck(:school_building_id))
  }

  scope :for_school, lambda { |school|
    joins(:school_building).merge(school.school_buildings)
  }

end
