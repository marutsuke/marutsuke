class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :section, null: false
      t.references :chapter, null: false, foreign_key: true
      t.timestamps
    end
  end
end
