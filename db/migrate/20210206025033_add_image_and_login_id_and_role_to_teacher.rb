class AddImageAndLoginIdAndRoleToTeacher < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :login_id, :string, after: :name
    add_column :teachers, :image, :string, after: :login_id
    add_column :teachers, :role, :integer, null: false, default: 10
  end
end
