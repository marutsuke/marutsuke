class AddSchoolIdAndEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :school_id, :integer, index: true
    add_column :users, :email, :string, null: false, default: '', after: :name, index: true
    add_column :users, :start_date, :date, null: false, default: '2020-01-01'
    add_column :users, :end_date, :date
    add_column :users, :activated, :boolean, default: true, null: false
  end
end
