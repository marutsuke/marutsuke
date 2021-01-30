class LessonGroupRequest < ApplicationRecord
  belongs_to :user
  belongs_to :school_building
  belongs_to :lesson_group

  validates :lesson_group_id, uniqueness: { scope: :user_id, case_sensitive: true }

  paginates_per 20

  enum status: {
    requested: 10,
    accepted: 20,
    rejected: 30,
  }

  scope :checked_recently_lgr, lambda {
    where(status: ['accepted', 'rejected'])
      .where(updated_at: 7.days.ago..Time.current)
  }

  scope :created_desc_order, -> {
    order(created_at: :desc)
  }

  def accept_user_attend
    update(status: 'accepted')
    create_lesson_group_user
  end

  def accept_user_attend_if_free_attend
    accept_user_attend if lesson_group.free_attend?
  end

  def attend_free?
    lesson_group.free_attend?
  end

  private

  def create_lesson_group_user
    LessonGroupUser.create(user_id: user_id, lesson_group_id: lesson_group_id)
  end

end
