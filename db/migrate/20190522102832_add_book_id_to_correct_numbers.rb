class AddBookIdToCorrectNumbers < ActiveRecord::Migration[5.2]
  def change
    add_reference :correct_numbers, :book, foreign_key: true
  end
end
