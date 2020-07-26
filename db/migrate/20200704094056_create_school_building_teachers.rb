class CreateSchoolBuildingTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :school_building_teachers do |t|
      t.belongs_to :school_building, index: true
      t.belongs_to :teacher, index: true
      t.boolean :main, default: true
      t.timestamps
    end
  end
end
