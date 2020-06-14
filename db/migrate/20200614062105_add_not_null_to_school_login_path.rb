# frozen_string_literal: true

class AddNotNullToSchoolLoginPath < ActiveRecord::Migration[5.2]
  def up
    change_column_null :schools, :login_path, false, ''
    change_column :schools, :login_path, :string, default: ''
  end

  def down
    change_column_null :schools, :login_path, true, nil
    change_column :schools, :login_path, :string, default: nil
  end
end
