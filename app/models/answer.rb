# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :text, length: { maximum: 800 }, allow_nil: true
  belongs_to :user
  belongs_to :question
  has_many :answer_images
end
