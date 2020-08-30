class AddIndexEmailToSchoolUser < ActiveRecord::Migration[6.0]
  def change
    add_index :school_users, :email
  end
end
