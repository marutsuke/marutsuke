class CreateJoinRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :join_requests do |t|
      t.belongs_to :user, index: true
      t.belongs_to :school_building, index: true
      t.belongs_to :school, index: true
      t.integer :status
      t.timestamps
    end
  end
end
