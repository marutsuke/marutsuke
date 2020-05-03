class ChangeUsersColumnEmailToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :email, :string, null: true
  end
  def down
    change_column :users, :email, :string, null: false
  end
end
