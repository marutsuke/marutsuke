class AddStartAtAndEndAtToLessonGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :lesson_groups, :start_at, :date, after: :school_year, null:false
    add_column :lesson_groups, :end_at, :date, after: :start_at
  end
end
