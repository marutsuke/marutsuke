class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
