# frozen_string_literal: true

class SchoolBuildingUser < ApplicationRecord
  belongs_to :user
  belongs_to :school_building

  validates :school_building_id, uniqueness: { scope: :user_id, case_sensitive: true }

  scope :main_order, lambda {
    order(main: 'desc')
  }

  scope :id_not_nil, lambda{
    where.not(id: nil)
  }

  scope :in_school, lambda{ |school|
    where(school_building_id: school.school_buildings.pluck(:id))
  }
end
