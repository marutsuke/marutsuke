class AddColumnsEmailToSchoolUser < ActiveRecord::Migration[6.0]
  def change
    add_column :school_users, :email, :string, index: true, after: :id
  end
end
