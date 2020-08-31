class AddLineStateToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :line_state_digest, :string
  end
end
