# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  belongs_to :lesson
end
