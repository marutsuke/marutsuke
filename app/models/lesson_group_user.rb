class LessonGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_group
  validates :user_id, uniqueness: { scope: :lesson_group_id, case_sensitive: true }


  scope :for_school, lambda { |school|
    joins(:lesson_group).merge(LessonGroup.for_school(school))
  }
end
