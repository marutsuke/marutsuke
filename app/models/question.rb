class Question < ApplicationRecord

  belongs_to :section
  has_many :small_questions

  def num
      self.section.questions.find_index(self) +1
  end
end
