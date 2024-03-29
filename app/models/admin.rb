class Admin < ApplicationRecord
  attr_accessor :admin_remember_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALIDATE_FORMAT_OF_EMAIL }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.admin_remember_token = self.class.new_token
    update_attribute(:remember_digest, self.class.digest(admin_remember_token))
  end

  def authenticated?(admin_remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(admin_remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
