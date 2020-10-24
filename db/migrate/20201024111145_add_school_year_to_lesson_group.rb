class AddSchoolYearToLessonGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :lesson_groups, :max_school_grade, :integer, after: :school_building_id
    add_column :lesson_groups, :min_school_grade, :integer, after: :school_building_id
    add_column :lesson_groups, :school_year, :integer, after: :school_building_id
  end
end
