class RemoveColumnBirthDayFromUser < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :birth_day, :date
  end

  def down
    add_column :users, :birth_day, :date, after: :email
  end
end
