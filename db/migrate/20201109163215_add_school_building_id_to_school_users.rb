class AddSchoolBuildingIdToSchoolUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :school_users, :school_building_id, :integer, after: :user_id
    add_index :school_users, :school_building_id
  end
end
