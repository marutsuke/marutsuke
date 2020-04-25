class DorpTables2 < ActiveRecord::Migration[5.2]
  def change
    drop_table :small_questions
    drop_table :user_books
  end
end
