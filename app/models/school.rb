class School < ApplicationRecord
  validates :name, presence: { message:"学校名を入力してください。" }, length: { maximum: 20, message:"名前は20文字以内でお願いします。" }, uniqueness: { message: "すでに同じ名前の学校が存在しています" }
  has_many :teachers, dependent: :destroy
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :teachers, allow_destroy: true
end
