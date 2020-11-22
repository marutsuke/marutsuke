class LessonGroupRequest < ApplicationRecord
  belongs_to :user
  belongs_to :school_building
  belongs_to :lesson_group

  validates :lesson_group_id, uniqueness: { scope: :user_id, case_sensitive: true }

  enum status: {
    requested: 10,
    accepted: 20,
    rejected: 30,
    closed: 40
  }

end