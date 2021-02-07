class AddIndexToTeachersLoginId < ActiveRecord::Migration[6.0]
  def change
    add_index :teachers, :login_id
  end
end
