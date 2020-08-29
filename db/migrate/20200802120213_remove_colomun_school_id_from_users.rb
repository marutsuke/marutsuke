class RemoveColomunSchoolIdFromUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :school_id
  end

  def down
    add_column :users, :school_id, :integer, index: true
  end
end
