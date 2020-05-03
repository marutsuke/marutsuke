class ChangeUsersColumnStartAtToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :start_at, :datetime, null: true
    add_index :users, :email
  end
  def down
    change_column :users, :start_at, :datetime, null: false
    remove_index :users, :email
  end
end
