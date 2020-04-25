class DropTable4 < ActiveRecord::Migration[5.2]
  def change
    drop_table :sections
    drop_table :chapters
    drop_table :books
  end
end
