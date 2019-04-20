class Section < ApplicationRecord

  belongs_to :chapter
  has_many :questions, dependent: :destroy


end
