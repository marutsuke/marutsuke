class CreateSmallQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :small_questions do |t|
      t.text :text, null: false
      t.string :image
      t.references :question, null: false, foreign_key:true
      t.timestamps
    end
  end
end
