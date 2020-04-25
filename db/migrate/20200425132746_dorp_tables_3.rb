class DorpTables3 < ActiveRecord::Migration[5.2]
  def change
    drop_table :questions
    drop_table :correct_numbers
  end
end
