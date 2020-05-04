# frozen_string_literal: true

class User < ApplicationRecord
  before_save { email&.downcase! }
  before_validation { user_auto_login_id_create }
  validates :name, presence: true, length: { maximum: 12 }
  validates :login_id, presence: true, uniqueness: true
  validates :email, format: { with: VALIDATE_FORMAT_OF_EMAIL },
                    length: { maximum: 50 },
                    uniqueness: { case_sensitive: false },
                    allow_nil: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  belongs_to :school

  def user_auto_login_id_create
    self.login_id = school_id.to_s + format('%07d', (User.last&.id || 0) + 1)
  end
end
