# frozen_string_literal: true

class CreateAnswers2 < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :text
      t.belongs_to :question, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
