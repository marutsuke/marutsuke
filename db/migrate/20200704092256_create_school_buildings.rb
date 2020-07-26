# frozen_string_literal: true

class CreateSchoolBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :school_buildings do |t|
      t.string :name, null: false
      t.belongs_to :school, index: true
      t.timestamps
    end
  end
end
