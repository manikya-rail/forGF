class AddNumberOfTeesToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :number_of_tees, :string
  end
end
