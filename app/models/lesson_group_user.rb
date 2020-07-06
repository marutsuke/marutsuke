class LessonGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_group
end
