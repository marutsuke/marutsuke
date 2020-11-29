class RenameColumnUserAuthenticationLineStateToken < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_authentications, :line_state_digest, :authentication_digest
  end
end
