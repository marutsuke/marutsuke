# frozen_string_literal: true

class CreateQuestionStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :question_statuses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :question, index: true
      t.integer :status, default: 10, null: false
      t.timestamps
    end
  end
end
