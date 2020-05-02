class RenameStartDateColumnToStartAt < ActiveRecord::Migration[5.2]
  def up
    rename_column :teachers, :end_date, :end_at
    rename_column :users, :start_date, :start_at
    rename_column :users, :end_date, :end_at
  end

  def dowwn
    rename_column :teachers, :end_date, :end_at
    rename_column :users, :start_date, :start_at
    rename_column :users, :end_date, :end_at
  end
end
