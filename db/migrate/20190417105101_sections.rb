class Sections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :correct_count, :integer, default: 0
  end
end
