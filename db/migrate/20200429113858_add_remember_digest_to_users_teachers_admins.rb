class AddRememberDigestToUsersTeachersAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remember_digest, :string
    add_column :teachers, :remember_digest, :string
    add_column :admins, :remember_digest, :string
  end
end
