class JoinRequest < ApplicationRecord
  belogs_to :user
  belogs_to :school_building
  belogs_to :school

  validates :school_building_id, uniqueness: { scope: :user_id, case_sensitive: true }

end
