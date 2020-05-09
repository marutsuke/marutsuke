# frozen_string_literal: true

class CreateQuestios < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :text
      t.string :image
      t.belongs_to :lesson, index: true
      t.timestamps
    end
  end
end
