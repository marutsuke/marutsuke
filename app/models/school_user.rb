class SchoolUser < ApplicationRecord
  belongs_to :user
  belongs_to :school_building

  validates :user_id, uniqueness: { scope: :school_id, case_sensitive: true }
end
