# frozen_string_literal: true

class SchoolBuildingUser < ApplicationRecord
  belongs_to :user
  belongs_to :school_building

  validates :school_building_id, uniqueness: { scope: :user_id, case_sensitive: true }

  scope :main_order, lambda {
    order(main: 'desc')
  }
end
