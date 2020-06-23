# frozen_string_literal: true

class AddDefaultToTeachersActivated < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:teachers, :activated, from: nil, to: false)
  end
end
