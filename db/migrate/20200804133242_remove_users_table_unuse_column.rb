class RemoveUsersTableUnuseColumn < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :login_count
    remove_column :users, :start_at
    remove_column :users, :end_at
    remove_column :users, :activated
  end

  def down
    add_column :users, :login_count, :integer
    add_column :users, :start_at, :datetime
    add_column :users, :end_at, :date_time
    add_column :users, :activated, :boolean, default: true, null: false
  end
end
