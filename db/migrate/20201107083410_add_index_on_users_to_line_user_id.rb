class AddIndexOnUsersToLineUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :line_user_id
  end
end
