class RemoveNullFalseFromTeachersEmail < ActiveRecord::Migration[6.0]
  def up
    change_column_null :teachers, :email, true
  end

  def down
    change_column_null :teachers, :email, false
  end
end
