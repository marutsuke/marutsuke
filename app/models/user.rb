# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :user_remember_token,
                :start_at_date, :start_at_hour, :start_at_min,
                :end_at_date, :end_at_hour, :end_at_min
  before_save { email&.downcase! }
  before_save { start_at_set }
  before_save { end_at_set }
  before_validation { auto_login_id_create }
  validates :name, presence: true, length: { maximum: 12 }
  validates :login_id, presence: true, uniqueness: true
  validates :email, format: { with: VALIDATE_FORMAT_OF_EMAIL },
                    length: { maximum: 50 },
                    uniqueness: { case_sensitive: false },
                    allow_blank: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_secure_password

  belongs_to :school
  has_many :answers
  has_many :tags, through: :user_tags
  has_many :user_tags

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.user_remember_token = self.class.new_token
    update_attribute(:remember_digest, self.class.digest(user_remember_token))
  end

  def authenticated?(user_remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(user_remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def auto_login_id_create
    self.login_id = school_id.to_s + format('%07d', (User.last&.id || 0) + 1)
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
  end
end
