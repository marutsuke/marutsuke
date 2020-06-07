class Tag < ApplicationRecord
  has_many :user_tags
  has_many :lesson_tags
end
