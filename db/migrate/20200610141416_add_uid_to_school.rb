# frozen_string_literal: true

class AddUidToSchool < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :login_path, :string, index: true, after: :id
  end
end
