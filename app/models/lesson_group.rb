# frozen_string_literal: true

class LessonGroup < ApplicationRecord
  belongs_to :school_building
  has_many :lesson_group_users
  has_many :users, through: :lesson_group_users
  has_many :lessons
end
