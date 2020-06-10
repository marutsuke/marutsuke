# frozen_string_literal: true

class RemoveUniqueLoginIdToUser < ActiveRecord::Migration[5.2]
  def up
    remove_index :users, :login_id
    add_index :users, :login_id
  end

  def down
    add_index :users, :login_id, unique: true
  end
end
