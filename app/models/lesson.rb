# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :school
  belongs_to :teacher
end
