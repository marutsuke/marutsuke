# frozen_string_literal: true

class AddActivationToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :activation_digest, :string, after: :remember_digest
    add_column :teachers, :activated_at, :datetime, after: :activation_digest
  end
end
