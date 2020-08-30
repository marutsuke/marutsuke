# frozen_string_literal: true

class School < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: true}
  validates :login_path, presence: true, uniqueness: { case_sensitive: true }
  has_many :teachers, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :school_users
  has_many :users, through: :school_users
  has_many :school_buildings, dependent: :destroy
  accepts_nested_attributes_for :teachers, allow_destroy: true
end
