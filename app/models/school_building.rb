# frozen_string_literal: true

class SchoolBuilding < ApplicationRecord
  belongs_to :school
  has_many :school_building_users
  has_many :users, through: :school_building_users
  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :school_id }
end
