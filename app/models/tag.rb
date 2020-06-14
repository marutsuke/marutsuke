# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, :school_id, presence: true, length: { maximum: 10 }
  validates :name, uniqueness: { scope: :school_id }
  has_many :user_tags
  has_many :lesson_tags
  has_many :users, through: :user_tags
  has_many :lessons, through: :lesson_tags
  belongs_to :school

  scope :saved, -> { where.not(id: nil) }
end
