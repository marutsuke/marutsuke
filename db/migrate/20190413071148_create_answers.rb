class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :answer, null: false
      t.references :small_question, null: false, foreign_key:true
      t.timestamps
    end
  end
end
