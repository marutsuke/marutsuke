# frozen_string_literal: true

class AddSchoolBuildingIdAndMoreToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :lesson_group_id, :integer, index: true
    add_column :lessons, :school_building_id, :integer, index: true
  end
end
