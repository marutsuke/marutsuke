class AddColumnSchoolBuildingIdToSchoolUser < ActiveRecord::Migration[6.0]
  def change
    add_column :school_users, :invited_school_building_id, :integer
  end
end
