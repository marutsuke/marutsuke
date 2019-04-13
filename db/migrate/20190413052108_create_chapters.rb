class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :chapter, null: false
      t.references :book, null: false, foreign_key: true
      t.timestamps
    end
  end
end
