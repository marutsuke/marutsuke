class AddIndexToSchoolsLoginPath < ActiveRecord::Migration[6.0]
  def change
    add_index :schools, :login_path
  end
end
