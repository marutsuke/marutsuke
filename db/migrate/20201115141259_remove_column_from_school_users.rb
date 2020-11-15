class RemoveColumnFromSchoolUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :school_users, :school_building_id
    remove_column :school_users, :invited_school_building_id
    remove_column :school_users, :name_at_school
    remove_column :school_users, :activation_digest
  end
  def down
    add_column :school_users, :school_building_id, :integer
    add_column :school_users, :invited_school_building_id, :integer
    add_column :school_users, :name_at_school, :string
    add_column :school_users, :activation_digest, :string
    add_index :school_users, :school_building_id
  end
end
