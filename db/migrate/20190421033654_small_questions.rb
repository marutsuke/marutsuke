class SmallQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :small_questions, :section, foreign_key: true
    add_reference :small_questions, :book, foreign_key: true
  end
end
