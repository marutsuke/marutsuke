class AddActivationToSchoolUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :school_users, :activation_digest, :string
    add_column :school_users, :activated_at, :datetime
  end
end
