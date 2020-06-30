# frozen_string_literal: true

class QuestionStatus < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :status, presence: true
end
