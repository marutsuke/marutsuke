class Answers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :image, :string
  end
end
