# frozen_string_literal: true

class SchoolBuildingUser < ApplicationRecord
  belongs_to :user
  belongs_to :school_building

  scope :main_order, lambda {
    order(main: 'desc')
  }
end
