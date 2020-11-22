class LessonGroupRequest < ApplicationRecord
  belongs_to :user
  belongs_to :school_building
  belongs_to :lesson_group

  validates :lesson_group_id, uniqueness: { scope: :user_id, case_sensitive: true }

  enum status: {
    requested: 10,
    accepted: 20,
    rejected: 30,
    closed: 40
  }

  scope :checked_recently_lgr, lambda {
    where(status: ['accepted', 'rejected'])
      .where(updated_at: 7.days.ago..Time.current)
  }

  def accept_user_attend
    update(status: 'accepted')
    create_lesson_group_user
  end


  private

  def create_lesson_group_user
    LessonGroupUser.create(user_id: user_id, lesson_group_id: lesson_group_id)
  end

end
