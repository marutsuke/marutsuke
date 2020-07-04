# frozen_string_literal: true

class CreateLessonGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_group_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :lesson_group, index: true
      t.timestamps
    end
  end
end
