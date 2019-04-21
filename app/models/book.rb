class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :small_questions
end