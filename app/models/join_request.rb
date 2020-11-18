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

  scope :checked_recently, lambda {
    where.not(status: ['requested', 'closed'])
      .where(updated_at: 7.days.ago..Time.current)
  }

  def accept_user_join_if_auto_invite
    accept_user_join if school_building.auto_invite?
  end


  def accept_user_join
    create_school_user
    create_main_school_building_user
  end

  private

  def create_school_user
    user.school_users.create(school_id: school.id, activated_at: Time.zone.now, activated: true)
  end

  def create_main_school_building_user
    user.school_building_users.create(school_building_id: school_building.id, main: true)
  end

end
