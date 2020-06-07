# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, :school_id, presence: true
  validates :name, uniqueness: { scope: :school_id }
  has_many :user_tags
  has_many :lesson_tags
  belongs_to :school
end
