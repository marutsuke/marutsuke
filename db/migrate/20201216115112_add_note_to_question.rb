class AddNoteToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :note, :text, after: :text
  end
end
