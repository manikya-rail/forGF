class CreateCourseImages < ActiveRecord::Migration[5.0]
  def change
    create_table :course_images do |t|
      t.belongs_to :course, foreign_key: true

      t.timestamps
    end
  end
end
