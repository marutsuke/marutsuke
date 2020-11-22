class AddFreeAttendToLessonGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :lesson_groups, :free_attend, :boolean, after: :max_school_grade, null: false, default: false
  end
end
