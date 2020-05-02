class ChangeDataStartAtToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :teachers, :start_at, :datetime
    change_column :teachers, :end_at, :datetime
    change_column :users, :start_at, :datetime
    change_column :users, :end_at, :datetime
  end

  def dowwn
    change_column :teachers, :start_at, :date
    change_column :teachers, :end_at, :date
    change_column :users, :start_at, :date
    change_column :users, :end_at, :date
  end

end
