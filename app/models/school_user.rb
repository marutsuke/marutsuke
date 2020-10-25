# == Schema Information
#
# Table name: school_users
#
#  id                         :bigint           not null, primary key
#  activated                  :boolean
#  activated_at               :datetime
#  activation_digest          :string(255)
#  email                      :string(255)
#  end_at                     :datetime
#  name_at_school             :string(255)
#  start_at                   :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  invited_school_building_id :integer
#  school_id                  :bigint
#  user_id                    :bigint
#
# Indexes
#
#  index_school_users_on_email      (email)
#  index_school_users_on_school_id  (school_id)
#  index_school_users_on_user_id    (user_id)
#
class SchoolUser < ApplicationRecord
  attr_accessor :school_user_activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  belongs_to :user, optional: true
  belongs_to :school
  validates :user_id, uniqueness: { scope: :school_id, case_sensitive: true }, allow_blank: true
  validates :email, format: { with: VALIDATE_FORMAT_OF_EMAIL },
                    length: { maximum: 50 },
                    uniqueness: { scope: :school_id, case_sensitive: false },
                    allow_blank: true
  validates :invited_school_building_id, presence: true
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def send_user_invitation
    UserInvitationMailer.user_invitation(self).deliver_now
  end

  def send_new_user_invitation
    UserInvitationMailer.new_user_invitation(self).deliver_now
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def main_school_building_user_create!
    SchoolBuildingUser.create!(user_id: user_id, school_building_id: invited_school_building_id, main: true)
  end

  def authenticated?(attribute, school_user_token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(school_user_token)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.school_user_activation_token = self.class.new_token
    self.activation_digest = self.class.digest(school_user_activation_token)
  end
end
