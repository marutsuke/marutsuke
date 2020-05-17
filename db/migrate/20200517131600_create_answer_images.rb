# frozen_string_literal: true

class CreateAnswerImages < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_images do |t|
      t.string :image
      t.belongs_to :answer, index: true
      t.timestamps
    end
  end
end
