class AddUniqueUidAndProviderToUserAuthentication < ActiveRecord::Migration[6.0]
  def change
    add_index :user_authentications, [:provider, :uid], unique: true
  end
end
