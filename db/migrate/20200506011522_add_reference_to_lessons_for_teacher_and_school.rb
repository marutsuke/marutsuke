# frozen_string_literal: true

class AddReferenceToLessonsForTeacherAndSchool < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :school, foreign_key: true
    add_reference :lessons, :teacher, foreign_key: true
  end
end
