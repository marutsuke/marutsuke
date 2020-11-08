class UserAuthentication < ApplicationRecord
  attr_accessor :line_state_token
  belongs_to :user, optional: true
  validates :user_id, uniqueness: true, allow_nil: true

  # has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def line_state_save
    self.line_state_token = self.class.new_token
    update_attribute(:line_state_digest, self.class.digest(line_state_token))
  end

  def line_authenticated?(user_line_state_token)
    return false if line_state_digest.nil?

    BCrypt::Password.new(line_state_digest).is_password?(user_line_state_token)
  end

end
