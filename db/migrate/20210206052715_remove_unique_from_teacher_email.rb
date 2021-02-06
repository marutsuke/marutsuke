class RemoveUniqueFromTeacherEmail < ActiveRecord::Migration[6.0]
  def up
    remove_index :teachers, :email
    add_index :teachers, :email
  end

  def down
    remove_index :teachers, :email
    add_index :teachers, :email, unique: true
  end
end
