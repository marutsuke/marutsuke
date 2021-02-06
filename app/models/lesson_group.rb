# frozen_string_literal: true

class LessonGroup < ApplicationRecord
  belongs_to :school_building
  has_many :lesson_group_users, dependent: :destroy
  has_many :users, through: :lesson_group_users, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :lesson_group_requests
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: [:school_building_id, :school_year], case_sensitive: false }
  validates :min_school_grade, presence: true
  validates :start_at, presence: true
  validate :min_school_grade_validate
  validate :max_school_grade_validate
  validate :start_at_and_end_at_validate


  scope :for_school_buildings_belonged_to_teacher_and_user,
        lambda { |teacher, user|
          for_school_buildings_belonged_to_teacher(teacher)
            .for_school_buildings_belonged_to_user(user)
        }

  scope :for_school_building, lambda { |school_building|
    where(school_building_id: school_building.id)
  }

  scope :for_school, lambda { |school|
    joins(:school_building).merge(school.school_buildings)
  }

  scope :for_school_buildings_belonged_to_user, lambda { |user|
    where(school_building_id: user.school_building_users.pluck(:school_building_id))
  }

  scope :for_school_buildings_belonged_to_teacher, lambda { |teacher|
    where(school_building_id: teacher.school_buildings.pluck(:id))
  }


  scope :for_school_grade, lambda { |school_grade|
    where(min_school_grade: school_grade)
      .where(max_school_grade: nil)
      .union(
        where.not(max_school_grade: nil)
          .where('min_school_grade <= ?', school_grade)
          .where('max_school_grade >= ?', school_grade)
      )
  }

  scope :for_school_year, lambda { |school_year|
    where(school_year: [nil, school_year])
  }

  scope :min_school_grade_order, lambda {
    order(min_school_grade: :asc)
  }

  scope :have_lesson_taught_by, lambda { |teacher|
    for_school_buildings_belonged_to_teacher(teacher)
    .where(id: teacher.lessons.pluck(:lesson_group_id).uniq)
  }

  scope :in_open, lambda {
    where('start_at <= ?', Time.zone.now)
      .where('end_at >= ?', Time.zone.now)
      .or(
        where('start_at <= ?', Time.zone.now)
          .where(end_at: nil)
      )
  }

  def request_of(user)
    user.lesson_group_requests.find_by(lesson_group_id: id)
  end

  def attended_by?(user)
    user.lesson_group_users.pluck(:lesson_group_id).include?(id)
  end

  def commented_status_exists_of?(user)
    # 60は、commentedのstatus
    lessons
      .joins(questions: :question_statuses)
      .where(question_statuses: {user_id: user.id})
      .where(question_statuses: {status: 60})
      .exists?
  end

  def to_check_status_exists_of?(teacher)
    # 50は、checkingのstatus
    lessons
      .where(teacher_id: teacher.id)
      .joins(questions: :question_statuses)
      .where(question_statuses: {status: 50})
      .exists?
  end

  def school_grade_target_of_user?(user)
    if max_school_grade.nil?
      user.school_grade == min_school_grade
    else
      user.school_grade <= max_school_grade && min_school_grade <= user.school_grade
    end
  end

  private


  def min_school_grade_validate
    return if (4..20).include?(min_school_grade) || min_school_grade.nil?

    errors.add(:min_school_grade, 'は不正な値です。')
  end

  def max_school_grade_validate
    return if max_school_grade.nil?

    errors.add(:max_school_grade, 'は対象学年上限より上の学年にしてください。') unless min_school_grade < max_school_grade
    errors.add(:max_school_grade, 'は不正な値です。') unless (5..20).include?(max_school_grade)
  end

  def start_at_and_end_at_validate
    return if end_at.nil?

    errors.add(:end_at, 'は公開終了日より後にしてください。') unless start_at < end_at
  end

end
