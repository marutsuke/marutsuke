# frozen_string_literal: true

class DropTagTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :tags
    drop_table :user_tags
    drop_table :lesson_tags
  end
end
