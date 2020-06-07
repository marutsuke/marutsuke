# frozen_string_literal: true

class CreateUserTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tags do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
