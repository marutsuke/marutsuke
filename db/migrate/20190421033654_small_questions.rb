class SmallQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :small_questions, :section
    add_reference :small_questions, :book
  end
end
