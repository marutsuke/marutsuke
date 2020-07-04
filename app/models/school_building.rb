# frozen_string_literal: true

class SchoolBuilding < ApplicationRecord
  belongs_to :school
  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :school_id }
end
