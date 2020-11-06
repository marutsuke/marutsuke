class AddSchoolGradeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :school_grade, :integer, null: false, after: :birth_day, default: 20
  end
end
