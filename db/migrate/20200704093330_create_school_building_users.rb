# frozen_string_literal: true

class CreateSchoolBuildingUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :school_building_users do |t|
      t.belongs_to :school_building, index: true
      t.belongs_to :user, index: true
      t.boolean :main, default: true
      t.timestamps
    end
  end
end
