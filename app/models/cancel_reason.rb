class CancelReason < ApplicationRecord
  belongs_to :user, optional: true
  validates :reason, presence: true
  validates :user_id, presence: true
  validates :confirm, presence: true, default: false
  enum reason: {
    school_canceled: 10,
    not_user_friendly: 20,
    expensive: 30,
    other: 40
  }

end
