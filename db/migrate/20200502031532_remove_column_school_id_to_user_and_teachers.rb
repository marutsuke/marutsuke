class RemoveColumnSchoolIdToUserAndTeachers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :school_id
    remove_column :teachers, :school_id
  end
end
