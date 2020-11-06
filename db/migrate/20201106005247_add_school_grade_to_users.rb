class AddSchoolGradeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :school_grade, :integer, after: :birth_day
  end
end
