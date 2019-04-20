class Question < ApplicationRecord

  belongs_to :section
  has_many :small_questions, dependent: :destroy


  def num
      self.section.questions.find_index(self) +1
  end
end
