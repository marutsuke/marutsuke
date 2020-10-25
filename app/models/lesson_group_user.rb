# == Schema Information
#
# Table name: lesson_group_users
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lesson_group_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_lesson_group_users_on_lesson_group_id  (lesson_group_id)
#  index_lesson_group_users_on_user_id          (user_id)
#
class LessonGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :lesson_group

  scope :for_school, lambda { |school|
    joins(:lesson_group).merge(LessonGroup.for_school(school))
  }
end
