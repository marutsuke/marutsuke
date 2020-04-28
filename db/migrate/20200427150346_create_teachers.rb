class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :school_id
      t.date :start_at
      t.date :end_date
      t.boolean :activated
      t.timestamps

      t.index :email, unique: true
    end
  end
end
