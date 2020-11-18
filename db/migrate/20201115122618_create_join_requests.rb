class CreateJoinRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :join_requests do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :school_building, index: true, null: false
      t.belongs_to :school, index: true, null: false
      t.integer :status, default: 10, null: false
      t.timestamps
    end
  end
end
