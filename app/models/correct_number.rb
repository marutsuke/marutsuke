class CorrectNumber < ApplicationRecord
  belongs_to :user
  belongs_to :small_question
  belongs_to :book
end
