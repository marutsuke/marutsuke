# frozen_string_literal: true

class Teacher < ApplicationRecord
  attr_accessor :teacher_remember_token, :teacher_activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALIDATE_FORMAT_OF_EMAIL }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :update, allow_blank: true
  has_secure_password
  belongs_to :school
  has_many :lessons, dependent: :destroy
  has_many :comments, dependent: :destroy

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

  def forget
    update_attribute(:remember_digest, nil)
  end

  def send_activation_mail
    TeacherMailer.account_activation(self).deliver_now
  end

  def resend_activation_mail
    update_activation_digest
    inactive
    TeacherMailer.account_activation(self).deliver_now
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def inactive
    update_columns(activated: false)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.teacher_activation_token = self.class.new_token
    self.activation_digest = self.class.digest(teacher_activation_token)
  end

  def update_activation_digest
    self.teacher_activation_token = self.class.new_token
    update_columns(activation_digest: self.class.digest(teacher_activation_token))
  end
end
