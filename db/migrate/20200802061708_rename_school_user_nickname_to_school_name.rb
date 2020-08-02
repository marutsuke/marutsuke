class RenameSchoolUserNicknameToSchoolName < ActiveRecord::Migration[6.0]
  def up
    rename_column :school_users, :nickname, :name_at_school
  end
  def down
    rename_column :school_users, :name_at_school, :nickname
  end
end
