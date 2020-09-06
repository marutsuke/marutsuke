class AddImageAndKanaToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image, :string, after: :birth_day
    add_column :users, :name_kana, :string, after: :name
  end
end
