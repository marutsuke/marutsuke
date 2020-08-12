class RemoveTitleFromQuestion < ActiveRecord::Migration[6.0]
  def up
    remove_column :questions, :title
  end

  def down
    add_column :questions, :title, :string, null: false
  end
end
