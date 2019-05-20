class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.references :user, null: false
      t.references :book, null: false
      t.timestamps
    end
  end
end
