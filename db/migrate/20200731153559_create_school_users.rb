class CreateSchoolUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :school_users do |t|
      t.belongs_to :school, index: true
      t.belongs_to :user, index: true
      t.string :nickname
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :activated
      t.timestamps
    end
  end
end
