class Chapter < ApplicationRecord
  belongs_to :book
  has_many :sections, dependent: :destroy

end
