class School < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  has_many :teachers, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :teachers, allow_destroy: true
end
