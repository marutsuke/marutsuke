class AddDefaultValueToSchoolUsersActivated < ActiveRecord::Migration[6.0]
  def up
    remove_column :school_users, :activated
    add_column :school_users, :activated, :boolean, default: false, null: false
  end

  def down
    remove_column :school_users, :activated
    change_column :school_users, :activated, :boolean, null: true
  end
end
