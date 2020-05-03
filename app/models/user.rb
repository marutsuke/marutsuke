class User < ApplicationRecord
  before_save { email&.downcase! }
  validates :name, presence: true, length: { maximum: 12 }
  validates :email, format: { with: VALIDATE_FORMAT_OF_EMAIL }, uniqueness:{ case_sensitive: false}, allow_nil: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  belongs_to :school

  def auto_login_id_create(school)
    login_id = school.id.to_s + sprintf("%06d", school.users.count)
  end
end
