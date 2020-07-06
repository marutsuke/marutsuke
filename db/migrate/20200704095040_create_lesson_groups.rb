# frozen_string_literal: true

class CreateLessonGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_groups do |t|
      t.string :name, null: false
      t.belongs_to :school_building, index: true
      t.timestamps
    end
  end
end
