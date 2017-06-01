class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :course_type
      t.text :bio
      t.string :website
      t.string :phone_num
      t.integer :total_par
      t.float :slope
      t.float :rating
      t.integer :length
      t.references :admin, index: true
      t.references :resort, index: true
      t.references :network, index: true
      t.timestamps
    end
  end
end
