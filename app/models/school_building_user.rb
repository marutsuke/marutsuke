# frozen_string_literal: true

# == Schema Information
#
# Table name: school_building_users
#
#  id                 :bigint           not null, primary key
#  main               :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  school_building_id :bigint
#  user_id            :bigint
#
# Indexes
#
#  index_school_building_users_on_school_building_id  (school_building_id)
#  index_school_building_users_on_user_id             (user_id)
#
class SchoolBuildingUser < ApplicationRecord
  belongs_to :user
  belongs_to :school_building

  validates :school_building_id, uniqueness: { scope: :user_id, case_sensitive: true }

  scope :main_order, lambda {
    order(main: 'desc')
  }
end
