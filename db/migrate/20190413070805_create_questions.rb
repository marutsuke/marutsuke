class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :text, null: false
      t.string :image
      t.references :section, null: false, foreign_key:true
      t.timestamps
    end
  end
end
