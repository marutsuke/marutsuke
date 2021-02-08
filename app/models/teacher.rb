# frozen_string_literal: true

class Teacher < ApplicationRecord
  attr_accessor :teacher_remember_token, :teacher_activation_token, :start_at_date, :start_at_hour, :start_at_min,
  :end_at_date, :end_at_hour, :end_at_min

  validates :name, presence: true, length: { maximum: 12 }
  validates :email, length: { maximum: 50 }, format: { with: VALIDATE_FORMAT_OF_EMAIL }, uniqueness: { case_sensitive: false }, allow_blank: true
  validates :login_id, presence: true, length: { maximum: 30 }, format: { with: VALIDATE_FORMAT_OF_ID, message: 'は半角英数字8文字以上です' }, uniqueness: { scope: :school_id, case_sensitive: false }
  validates :role, presence: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password, presence: true, length: { minimum: 8 }, on: :update, allow_blank: true
  validate :start_at_and_end_at_validate
  validates :start_at, presence: true
  validate :image_size

  before_save :downcase_email
  before_create :create_activation_digest
  before_validation { start_at_set }
  before_validation { end_at_set }

  has_secure_password
  belongs_to :school
  has_many :lessons, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :school_building_teachers
  has_many :school_buildings, through: :school_building_teachers

  paginates_per 20
  mount_uploader :image, ImageUploader

  enum role: {
    general_teacher: 10,
    regular_teacher: 20,
    school_building_owner: 30,
    school_owner: 40
  }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.teacher_remember_token = self.class.new_token
    update_attribute(:remember_digest, self.class.digest(teacher_remember_token))
  end

  def authenticated?(attribute, teacher_token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(teacher_token)
  end

  def regular_teacher_authority?
    regular_teacher? || school_building_owner? || school_owner?
  end

  def school_building_owner_authority?
    school_building_owner? || school_owner?
  end

  def school_owner_authority?
    school_owner?
  end

  def manager_of?(teacher)
    return false unless school_building_owner_authority?
    return false if teacher == self
    teacher.main_school_building.id == main_school_building.id
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def send_activation_mail
    TeacherMailer.account_activation(self).deliver_now
  end

  def resend_activation_mail
    update_activation_digest
    inactive
    TeacherMailer.resend_account_activation(self).deliver_now
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def inactive
    update_columns(activated: false)
  end

  def main_school_building
    school_building_teachers.find_by(main: true)&.school_building
  end

  def sub_school_buildings
    school_buildings.joins(:school_building_teachers).merge(SchoolBuildingTeacher.where(main: false)).distinct
  end

  def school_buildings_not_belog_to
    ids = school_buildings.pluck(:id)
    school.school_buildings.where.not(id: ids)
  end

  private

  def downcase_email
    self.email = email&.downcase
    self.email = nil if self.email.blank?
  end

  def create_activation_digest
    self.teacher_activation_token = self.class.new_token
    self.activation_digest = self.class.digest(teacher_activation_token)
  end

  def update_activation_digest
    self.teacher_activation_token = self.class.new_token
    update_columns(activation_digest: self.class.digest(teacher_activation_token))
  end

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

    errors.add(:end_at, 'は業務終了日時より後にしてください。') unless start_at < end_at
  end

  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end

end
