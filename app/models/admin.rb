class Admin < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALIDATE_FORMAT_OF_EMAIL }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

end
