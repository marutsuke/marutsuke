class JoinRequest < ApplicationRecord
  belongs_to :user
  belongs_to :school_building
  belongs_to :school

  validates :school_id, uniqueness: { scope: :user_id, case_sensitive: true }

  enum status: {
    requested: 10,
    accepted: 20,
    rejected: 30,
    closed: 40
  }



end
