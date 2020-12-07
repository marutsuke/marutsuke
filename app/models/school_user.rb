class SchoolUser < ApplicationRecord
  attr_accessor :start_at_date, :start_at_hour, :start_at_min,
  :end_at_date, :end_at_hour, :end_at_min
  before_save { start_at_set }
  before_save { end_at_set }

  belongs_to :user, optional: true
  belongs_to :school
  validates :user_id, uniqueness: { scope: :school_id, case_sensitive: true }, allow_blank: true


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
  end
end
