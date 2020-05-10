# frozen_string_literal: true

class AddDisplayOrderToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :display_order, :integer, null: false, default: 1
  end
end
