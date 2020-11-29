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
  belongs_to :user, optional: true
  belongs_to :school
  validates :user_id, uniqueness: { scope: :school_id, case_sensitive: true }, allow_blank: true


  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def main_school_building_user_create!
    SchoolBuildingUser.create!(user_id: user_id, school_building_id: invited_school_building_id, main: true)
  end

end
