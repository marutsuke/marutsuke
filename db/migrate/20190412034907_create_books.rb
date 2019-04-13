class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false, unique: true
      t.string :image
      t.timestamps
    end
  end
end