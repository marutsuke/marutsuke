class RemoveEmailFromSchoolUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :school_users, :email
  end
  def down
    add_column :school_users, :email, :string
    add_index :school_users, :email
  end
end
