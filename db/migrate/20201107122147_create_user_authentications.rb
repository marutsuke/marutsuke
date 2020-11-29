class CreateUserAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :user_authentications do |t|
      t.string :provider
      t.string :uid, index: true
      t.belongs_to :user, index: true
      t.string :line_state_digest
      t.timestamps
    end
  end
end
