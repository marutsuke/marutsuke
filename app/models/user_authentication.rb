class UserAuthentication < ApplicationRecord
  attr_accessor :authentication_token
  belongs_to :user, optional: true
  validates :user_id, uniqueness: { scope: :provider, case_sensitive: true }, allow_nil: true

  # has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authentication_token_save
    self.authentication_token = self.class.new_token
    update_attribute(:authentication_digest, self.class.digest(authentication_token))
  end

  def user_authenticated?(authentication_token)
    return false if authentication_digest.nil?

    BCrypt::Password.new(authentication_digest).is_password?(authentication_token)
  end

end
