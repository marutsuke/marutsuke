class LessonGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_group

  scope :for_school, lambda { |school|
    joins(:lesson_group).merge(LessonGroup.for_school(school))
  }
end
