# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.string :image
      t.belongs_to :teacher, index: true
      t.belongs_to :answer, index: true
      t.timestamps
    end
  end
end
