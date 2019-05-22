class AddIntroductionToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :introduction, :text
  end
end
