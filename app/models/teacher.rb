# frozen_string_literal: true

class Teacher < ApplicationRecord
  attr_accessor :teacher_remember_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALIDATE_FORMAT_OF_EMAIL }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password
  belongs_to :school

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

  def authenticated?(teacher_remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(teacher_remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
