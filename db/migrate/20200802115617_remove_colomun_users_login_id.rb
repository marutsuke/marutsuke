class RemoveColomunUsersLoginId < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :login_id
  end

  def down
    add_column :users, :login_id, :string, null: false
    add_index :users, :login_id
  end
end
