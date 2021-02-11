class AddUniqueIndexToUserIdAndQuestionIdToQuestionStatuses < ActiveRecord::Migration[6.0]
  def up
    add_index :question_statuses, [:user_id, :question_id], unique: true
  end
  def down
    remove_index :question_statuses, [:user_id, :question_id]
  end
end
