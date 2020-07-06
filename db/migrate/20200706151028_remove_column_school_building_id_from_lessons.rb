# frozen_string_literal: true

class RemoveColumnSchoolBuildingIdFromLessons < ActiveRecord::Migration[5.2]
  def up
    remove_column :lessons, :school_building_id
  end

  def down
    add_column :lessons, :school_building_id, :integer
  end
end
