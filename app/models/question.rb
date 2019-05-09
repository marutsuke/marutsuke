class Question < ApplicationRecord

  belongs_to :section
  has_many :small_questions, dependent: :destroy
  mount_uploader :image, ImageUploader


  def num
      self.section.questions.find_index(self) +1
  end

  validates :text, presence:true

end
