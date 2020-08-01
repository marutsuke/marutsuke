class SchoolUser < ApplicationRecord
  attr_accessor :school_user_activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  belongs_to :user, optional: true
  belongs_to :school
  validates :user_id, uniqueness: { scope: :school_id, case_sensitive: true }
  validates :email, format: { with: VALIDATE_FORMAT_OF_EMAIL },
                    length: { maximum: 50 },
                    uniqueness: { scope: :school_id, case_sensitive: false },
                    allow_blank: true
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def create_activation_digest
    self.school_user_activation_token = self.class.new_token
    self.activation_digest = self.class.digest(school_user_activation_token)
  end
end
