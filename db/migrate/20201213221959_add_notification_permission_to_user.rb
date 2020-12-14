class AddNotificationPermissionToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :notification_permission, :boolean, after: :remember_digest, null: false, default: false
  end
end
