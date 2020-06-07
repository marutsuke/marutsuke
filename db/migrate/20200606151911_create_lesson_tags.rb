class CreateLessonTags < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_tags do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :lesson, index: true
      t.timestamps
    end
  end
end
