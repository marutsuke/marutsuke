class AddCorrectCountToSmallQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :small_questions, :correct_count, :integer, default: 0
    add_column :small_questions, :incorrect_count, :integer, default: 0
    add_column :small_questions, :last_correct_day, :date
  end
end
