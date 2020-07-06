# frozen_string_literal: true

class SchoolBuildingUser < ApplicationRecord
  belongs_to :user
  belongs_to :school_building
end
