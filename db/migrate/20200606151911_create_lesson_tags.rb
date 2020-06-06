class CreateLessonTags < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_tags do |t|

      t.timestamps
    end
  end
end
