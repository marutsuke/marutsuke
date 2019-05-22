class CreateCorrectNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :correct_numbers do |t|
      t.references :user, null:false
      t.references :small_question, null:false
      t.timestamps
    end
  end
end
