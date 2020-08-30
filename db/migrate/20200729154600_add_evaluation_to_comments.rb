class AddEvaluationToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :evaluation, :integer, null: false, default: 10, after: :answer_id
  end
end


