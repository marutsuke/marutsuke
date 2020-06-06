class CreateUserTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tags do |t|

      t.timestamps
    end
  end
end
