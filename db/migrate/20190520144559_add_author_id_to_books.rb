class AddAuthorIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :author_id, :integer, default: 1
  end
end
