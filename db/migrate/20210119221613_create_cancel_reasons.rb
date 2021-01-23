class CreateCancelReasons < ActiveRecord::Migration[6.0]
  def change
    create_table :cancel_reasons do |t|
      t.belongs_to :user, index: true, null: false
      t.integer :reason, null: false
      t.text :text
      t.boolean :confirm, default: false, null: false
      t.timestamps
    end
  end
end
