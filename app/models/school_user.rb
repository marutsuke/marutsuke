class SchoolUser < ApplicationRecord
  attr_accessor :start_at_date, :start_at_hour, :start_at_min,
  :end_at_date, :end_at_hour, :end_at_min
  before_validation { start_at_set }
  before_validation { end_at_set }

  belongs_to :user, optional: true
  belongs_to :school
  validates :user_id, uniqueness: { scope: :school_id, case_sensitive: true }, allow_blank: true
  validates :start_at, presence: true
  validate :start_at_and_end_at_validate

  scope :active, lambda  {
    where(activated: true)
      .where('start_at <= ?', Time.zone.now)
      .where('end_at >= ?', Time.zone.now)
      .or(
        where(activated: true)
          .where('start_at <= ?', Time.zone.now)
          .where(end_at: nil)
      )

  }

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def main_school_building_user_create!
    SchoolBuildingUser.create!(user_id: user_id, school_building_id: invited_school_building_id, main: true)
  end

  private

  def start_at_set
    if start_at_date.present? && start_at_hour.present? && start_at_min.present?
      self.start_at = Time.zone.parse("#{start_at_date} #{start_at_hour}:#{start_at_min}:00")
    end
  end

  def end_at_set
    if end_at_date.present? && end_at_hour.present? && end_at_min.present?
      self.end_at = Time.zone.parse("#{end_at_date} #{end_at_hour}:#{end_at_min}:00")
    end
    if end_at_date.blank? && end_at_hour.blank? && end_at_min.blank?
      self.end_at = nil
    end
  end

  def start_at_and_end_at_validate
    return if end_at.nil?

    errors.add(:end_at, 'はアカウント開始日時より後にしてください。') unless start_at < end_at
  end

end
