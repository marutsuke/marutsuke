class Question < ApplicationRecord

  belongs_to :section
  has_many :small_questions

end
