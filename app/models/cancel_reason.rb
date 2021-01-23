class CancelReason < ApplicationRecord
  belongs_to :user, optional: true
  validates :reason, presence: true
  validates :user_id, presence: true
  validate :other_require_text
  enum reason: {
    school_canceled: 10,
    not_user_friendly: 20,
    expensive: 30,
    other: 40
  }

  private

  def other_require_text
    return unless other?

    errors.add(:text, 'をご記入ください') if text.blank?
  end

end
